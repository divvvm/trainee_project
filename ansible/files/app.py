from flask import Flask, request, jsonify
import psycopg2
from sentence_transformers import SentenceTransformer
import numpy as np
import requests
import json

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False

# Initialize the model for generating vectors
model = SentenceTransformer('all-MiniLM-L6-v2')

# Database connection to RDS
def get_db_connection():
    conn = psycopg2.connect(
        host="postgres-llm.cipiqwsk4k7o.us-east-1.rds.amazonaws.com",
        database="mydb",
        user="denys",
        password="password123",
        port="5432",
        sslmode="require"
    )
    return conn

def init_db():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("CREATE EXTENSION IF NOT EXISTS vector;")
    cur.execute("""
        CREATE TABLE IF NOT EXISTS documents (
            id SERIAL PRIMARY KEY,
            content TEXT NOT NULL,
            embedding vector(384)
        );
    """)
    conn.commit()
    cur.close()
    conn.close()

# Route to add context to the database
@app.route('/add_context', methods=['POST'])
def add_context():
    try:
        data = request.get_json()
        content = data.get('content', '')
        if not content:
            return jsonify({"error": "Content not provided"}), 400

        # Generate vector for the content
        embedding = model.encode(content).tolist()

        # Insert into the database
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute(
            "INSERT INTO documents (content, embedding) VALUES (%s, %s::vector) RETURNING id",
            (content, str(embedding))
        )
        new_id = cur.fetchone()[0]
        conn.commit()
        conn.close()

        return jsonify({"message": f"Context added with ID: {new_id}"})
    except Exception as e:
        return jsonify({"error": f"Error adding context: {str(e)}"}), 500

# Route for automatic context-based or direct query to Ollama
@app.route('/ask', methods=['GET'])
def ask():
    try:
        prompt = request.args.get('prompt', 'Prompt not provided')
        if not prompt:
            return jsonify({"error": "Prompt not provided"}), 400

        # Generate vector for the prompt
        query_embedding = model.encode(prompt).tolist()

        # Retrieve the nearest context from the database
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute(
            "SELECT content FROM documents ORDER BY embedding <-> %s::vector LIMIT 1",
            (str(query_embedding),)
        )
        result = cur.fetchone()
        context = result[0] if result else None
        conn.close()

        # Formulate the prompt for Ollama
        if context:
            full_prompt = f"Context: {context}\nPrompt: {prompt}"
        else:
            full_prompt = f"Prompt: {prompt}"

        # Send the prompt to Ollama
        response = requests.post(
            "http://localhost:11434/api/generate",
            json={"model": "llama3", "prompt": full_prompt},
            stream=True
        )
        answer = ""
        for line in response.iter_lines():
            if line:
                decoded_line = line.decode('utf-8')
                data = json.loads(decoded_line)
                answer += data.get("response", "")
                if data.get("done", False):
                    break

        return jsonify({"response": answer, "context": context if context else "No relevant context found"})
    except Exception as e:
        return jsonify({"error": f"Processing error: {str(e)}"}), 500

# Root route
@app.route('/')
def home():
    return jsonify({"message": "Welcome to the Flask server!"})

if __name__ == "__main__":
    init_db()
    app.run(host="0.0.0.0", port=5000, debug=True)
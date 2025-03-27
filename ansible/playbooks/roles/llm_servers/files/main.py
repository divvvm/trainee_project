from fastapi import FastAPI
import requests
import psycopg2
from pydantic import BaseModel

app = FastAPI()

DB_CONFIG = {
    "host": "postgres-llm.us-east-1.rds.amazonaws.com",
    "port": 5432,
    "user": "denys",
    "password": "password123",
    "database": "mydb"
}

class ChatRequest(BaseModel):
    prompt: str

@app.post("/chat")
def chat(request: ChatRequest):
    conn = psycopg2.connect(**DB_CONFIG)
    cursor = conn.cursor()

    try:
        query_embedding = [0.1, 0.2] + [0.0] * 382
        cursor.execute(
            "SELECT message, response FROM messages ORDER BY embedding <-> %s LIMIT 1",
            (query_embedding,)
        )
        similar = cursor.fetchone()
        context = similar[1] if similar else ""

        response = requests.post(
            "http://localhost:11434/api/generate",
            json={
                "model": "llama3",
                "prompt": f"Context: {context}\n\nUser: {request.prompt}",
                "stream": False
            }
        )
        ollama_response = response.json().get("response", "")

        response_embedding = [0.4, 0.5] + [0.0] * 382
        cursor.execute(
            "INSERT INTO messages (message, response, embedding) VALUES (%s, %s, %s)",
            (request.prompt, ollama_response, response_embedding)
        )
        conn.commit()

        return {"response": ollama_response}
    finally:
        cursor.close()
        conn.close()
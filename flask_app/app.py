from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/ask', methods=['GET'])
def ask():
    # Отримуємо параметр prompt з URL
    prompt = request.args.get('prompt', 'Немає запиту')
    # Повертаємо просту відповідь для тестування
    return jsonify({"response": f"Ти запитав: {prompt}"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
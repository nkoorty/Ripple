from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/', methods=['GET'])
def get_request():
    return "This is a GET request."

@app.route('/', methods=['POST'])
def post_request():
    data = request.json
    return jsonify({"message": "Received POST request", "data": data})

if __name__ == '__main__':
    app.run(debug=True)
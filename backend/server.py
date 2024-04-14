from flask import Flask, request, jsonify
import os

app = Flask(__name__)

@app.route('/test', methods=['GET'])
def get_request():
    dataJ = {
        'message': 'This is a JSON response!'
    }
    return jsonify(dataJ)

@app.route('/createGroup', methods=['POST'])
def create_group_request():
    try:
        data = request.json 
        os.system('npx hardhat run scripts/addressInteraction.js --network xrplsidechain')
        print(data)

        return jsonify({"message": "Received POST request"})
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    
@app.route('/createPaymentSplit', methods=['POST'])
def payment_split_request():
    try:
        data = request.json
        os.system('npx hardhat run scripts/addressInteraction.js --network xrplsidechain') 
        print(data)
        return jsonify({"message": "Payment has been Split"})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
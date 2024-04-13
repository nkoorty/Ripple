from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/test', methods=['GET'])
def get_request():
    dataJ = {
        'message': 'This is a JSON response!'
    }
    return jsonify(dataJ)

@app.route('/post', methods=['POST'])
def post_request():
    try:
        data = request.json 
        user_private_key = data.get('userPrivateKey')
        item_amount = data.get('itemAmount')
        item = data.get('item')
        item_vendor_public_key = data.get('itemVendorPublicKey')
        interval = data.get('interval')


        return jsonify({"message": "Received POST request", "data": data})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
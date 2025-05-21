import uuid
from datetime import datetime

from flask import Flask, request
from flask_cors import CORS
import redis  # Import Redis

import woody

app = Flask('my_api')
cors = CORS(app)

# Connexion à Redis
redis_db = redis.Redis(host='redis', port=6379, db=0, decode_responses=True)


@app.get('/api/ping')
def ping():
    return 'ping'

# ### 3. Order Service ###
@app.route('/api/orders/do', methods=['GET'])
def create_order():
    product = request.args.get('order')
    order_id = str(uuid.uuid4())

    process_order(order_id, product)
    return f"Your process {order_id} has been created with this product : {product}"


@app.route('/api/orders/', methods=['GET'])
def get_order():
    order_id = request.args.get('order_id')
    status = woody.get_order(order_id)
    return f'order "{order_id}": {status}'


# ### 4. Internal ###
def process_order(order_id, order):
    status = woody.make_heavy_validation(order)
    woody.save_order(order_id, status, order)


if __name__ == "__main__":
    woody.launch_server(app, host='0.0.0.0', port=5000)

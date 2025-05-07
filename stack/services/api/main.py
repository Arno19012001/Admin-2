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


# ### 1. Misc service ###
@app.route('/api/misc/time', methods=['GET'])
def get_time():
    return f'misc: {datetime.now()}'


@app.route('/api/misc/heavy', methods=['GET'])
def get_heavy():
    name = request.args.get('name')
    if not name:
        return "Missing 'name' parameter", 400

    cache_key = f'heavy:{name}'
    cached = redis_db.get(cache_key)

    if cached:
        return f'cached {datetime.now()}: {cached}'

    r = woody.make_some_heavy_computation(name)
    redis_db.setex(cache_key, 60, r)  # expire after 60 seconds
    return f'computed {datetime.now()}: {r}'


# ### 2. Product Service ###
@app.route('/api/products', methods=['GET'])
def add_product():
    product = request.args.get('product')
    woody.add_product(str(product))

    # Invalidate cache
    redis_db.delete('last_product')

    return str(product) or "none"


@app.route('/api/products/<int:product_id>', methods=['GET'])
def get_product(product_id):
    return "not yet implemented"


@app.route('/api/products/last', methods=['GET'])
def get_last_product():
    cached = redis_db.get('last_product')

    if cached:
        return f'cached {datetime.now()} - {cached}'

    last_product = woody.get_last_product()  # very slow
    redis_db.setex('last_product', 30, last_product)  # cache 30s

    return f'db {datetime.now()} - {last_product}'


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

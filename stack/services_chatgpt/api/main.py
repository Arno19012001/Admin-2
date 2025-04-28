import uuid
import threading
from datetime import datetime

from flask import Flask, request
from flask_cors import CORS
import redis
import woody

app = Flask('my_api')
cors = CORS(app)

# Connexion Redis
redis_db = redis.Redis(host='redis', port=6379, db=0, decode_responses=True)

# ### Ping
@app.get('/api/ping')
def ping():
    return 'ping'


# ### 1. Misc service (divers)
@app.route('/api/misc/time', methods=['GET'])
def get_time():
    return f'misc: {datetime.now()}'

@app.route('/api/misc/heavy', methods=['GET'])
def get_heavy():
    name = request.args.get('name', '')
    cache_key = f"heavy:{name}"
    cached_value = redis_db.get(cache_key)

    if cached_value:
        return f'{datetime.now()}: {cached_value} (cached)'

    result = woody.make_some_heavy_computation(name)
    redis_db.setex(cache_key, 60, result)  # expire dans 60 secondes

    return f'{datetime.now()}: {result}'


# ### 2. Product Service
@app.route('/api/products', methods=['GET'])
def add_product():
    product = request.args.get('product')
    if not product:
        return "No product provided", 400

    woody.add_product(str(product))
    redis_db.delete("products:last")  # invalider le cache
    return str(product)

@app.route('/api/products/<int:product_id>', methods=['GET'])
def get_product(product_id):
    return "not yet implemented"

@app.route('/api/products/last', methods=['GET'])
def get_last_product():
    cache_key = "products:last"
    cached_value = redis_db.get(cache_key)

    if cached_value:
        return f'db: {datetime.now()} - {cached_value} (cached)'

    last_product = woody.get_last_product()
    redis_db.setex(cache_key, 60, last_product)  # expire dans 60 secondes

    return f'db: {datetime.now()} - {last_product}'


# ### 3. Order Service
@app.route('/api/orders/do', methods=['GET'])
def create_order():
    product = request.args.get('order')
    if not product:
        return "No order provided", 400

    order_id = str(uuid.uuid4())

    # traitement asynchrone
    threading.Thread(target=process_order, args=(order_id, product)).start()

    return f"Your process {order_id} has been created with this product : {product}"

@app.route('/api/orders/', methods=['GET'])
def get_order():
    order_id = request.args.get('order_id')
    status = woody.get_order(order_id)

    return f'order \"{order_id}\": {status}'


# #### 4. Internal service
def process_order(order_id, order):
    status = woody.make_heavy_validation(order)
    woody.save_order(order_id, status, order)


if __name__ == "__main__":
    woody.launch_server(app, host='0.0.0.0', port=5000)

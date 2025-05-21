from datetime import datetime

from flask import Flask, request
from flask_cors import CORS
import redis  # Import Redis

import app.woody as woody

app = Flask('my_api')
cors = CORS(app)

# Connexion à Redis
redis_db = redis.Redis(host='redis', port=6379, db=0, decode_responses=True)


@app.get('/api/ping')
def ping():
    return 'ping'

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

if __name__ == "__main__":
    woody.launch_server(app, host='0.0.0.0', port=5000)

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


if __name__ == "__main__":
    woody.launch_server(app, host='0.0.0.0', port=5000)

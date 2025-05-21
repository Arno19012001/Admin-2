import uuid
import pika
import json
import os

from flask import Flask, request
from flask_cors import CORS
# import woody # woody n'est plus directement utilisé par ce fichier pour process_order

app = Flask('my_api')
app.url_map.strict_slashes = False
cors = CORS(app)

RABBITMQ_HOST = os.getenv('RABBITMQ_HOST', 'localhost')

def get_rabbitmq_connection():
    return pika.BlockingConnection(pika.ConnectionParameters(host=RABBITMQ_HOST))

@app.get('/api/ping')
def ping():
    return 'ping_order'

# ### 3. Order Service ###
@app.route('/api/orders/do', methods=['GET'])
def create_order_request(): # Renommé pour clarté
    product = request.args.get('order')
    if not product:
        return "Product parameter is missing", 400
        
    order_id = str(uuid.uuid4())

    message_body = {
        'order_id': order_id,
        'product': product
    }

    try:
        connection = get_rabbitmq_connection()
        channel = connection.channel()
        
        # Déclare la queue (idempotent, peut être déclaré par le producteur et le consommateur)
        # durable=True signifie que la file survivra à un redémarrage de RabbitMQ
        channel.queue_declare(queue='order_queue', durable=True)
        
        channel.basic_publish(
            exchange='', # Exchange par défaut
            routing_key='order_queue', # Nom de la queue
            body=json.dumps(message_body),
            properties=pika.BasicProperties(
                delivery_mode=pika.spec.PERSISTENT_DELIVERY_MODE # Rend le message persistant
            )
        )
        connection.close()
        return f"Your order {order_id} for product '{product}' has been received and is being processed.", 202
    except pika.exceptions.AMQPConnectionError as e:
        # Log l'erreur
        print(f"Error connecting to RabbitMQ: {e}")
        return "Failed to queue order due to a connection error with the message broker.", 500
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        return "An unexpected error occurred while trying to queue the order.", 500


@app.route('/api/orders', methods=['GET'])
def get_order_status(): # Renommé pour clarté
    # Ce endpoint dépendra de la logique de woody.py qui doit pouvoir se connecter à la DB
    # et n'est pas directement affecté par RabbitMQ, si ce n'est que le statut de la commande
    # sera mis à jour par le worker.
    # Pour que cela fonctionne, woody.py doit être capable de lire les variables d'environnement
    # de la base de données si elles sont passées au conteneur API (order).
    # Si woody.py est uniquement utilisé par le worker, alors ce endpoint devra peut-être être repensé
    # ou l'API order devra aussi avoir accès à woody.py et à la DB.
    # Assumons que woody.py est accessible et configuré pour la DB.
    import woody # Importer ici pour éviter dépendance si woody non nécessaire pour toutes les routes
    order_id = request.args.get('order_id')
    if not order_id:
        return "order_id parameter is missing", 400
    status = woody.get_order(order_id) # woody.get_order doit exister et fonctionner
    if status:
        return f'Order "{order_id}": {status[0] if isinstance(status, tuple) else status}'
    return f'Order "{order_id}" not found or status unavailable.', 404

# La fonction process_order est maintenant gérée par le worker
# def process_order(order_id, order):
#     status = woody.make_heavy_validation(order)
#     woody.save_order(order_id, status, order)

if __name__ == "__main__":
    # woody.launch_server(app, host='0.0.0.0', port=5000) # Le launch_server de woody.py est spécifique
    # Utilisez le lancement Flask standard ou celui de werkzeug si woody.launch_server fait plus
    # Pour la simplicité, si woody.launch_server est juste un run_simple, on peut le garder.
    # S'il est complexe, il faut le répliquer ou s'assurer qu'il est accessible.
    # Pour l'instant, supposons que woody.launch_server est un simple wrapper de app.run ou run_simple.
    # S'il n'est pas disponible car on n'importe plus woody globalement:
    from werkzeug.serving import run_simple
    run_simple('0.0.0.0', 5000, app, use_reloader=True, threaded=False)

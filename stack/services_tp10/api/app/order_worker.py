import pika
import json
import time
import os
import woody # woody.py doit être dans le même répertoire ou PYTHONPATH doit être configuré

RABBITMQ_HOST = os.getenv('RABBITMQ_HOST', 'localhost')

def process_order_message(ch, method, properties, body):
    print(f" [x] Received {body}")
    try:
        message = json.loads(body)
        order_id = message.get('order_id')
        product = message.get('product')

        if not order_id or not product:
            print(" [!] Invalid message format. Missing order_id or product.")
            # Rejeter le message sans le remettre en file si le format est mauvais
            ch.basic_reject(delivery_tag=method.delivery_tag, requeue=False)
            return

        print(f" [+] Processing order {order_id} for product {product}...")
        
        # Logique de traitement (anciennement dans process_order)
        status = woody.make_heavy_validation(product) # Simule un traitement long
        woody.save_order(order_id, status, product)   # Sauvegarde en base
        
        print(f" [v] Order {order_id} processed and saved with status: {status}")
        
        # Accuser réception du message pour le retirer de la file
        ch.basic_ack(delivery_tag=method.delivery_tag)
        print(f" [>] Message for order {order_id} acknowledged.")

    except json.JSONDecodeError:
        print(" [!] Failed to decode JSON from message.")
        ch.basic_reject(delivery_tag=method.delivery_tag, requeue=False) # Mauvais format, ne pas remettre en file
    except Exception as e:
        print(f" [!] Error processing message for order {order_id if 'order_id' in locals() else 'Unknown'}: {e}")
        # En cas d'erreur de traitement (ex: DB down), on pourrait vouloir remettre en file après un délai.
        # Pour la simplicité, ici on rejette sans remettre en file pour éviter boucle infinie si erreur persistante.
        # Dans un vrai système, on utiliserait une dead-letter queue ou des retries plus sophistiqués.
        ch.basic_nack(delivery_tag=method.delivery_tag, requeue=False) # ou True si on veut réessayer


def main():
    connection = None
    retry_interval = 5 # secondes
    while True: # Boucle de reconnexion
        try:
            print(" [*] Trying to connect to RabbitMQ...")
            connection = pika.BlockingConnection(pika.ConnectionParameters(host=RABBITMQ_HOST))
            channel = connection.channel()

            # Déclare la queue (idempotent). `durable=True` pour la persistance.
            channel.queue_declare(queue='order_queue', durable=True)
            print(' [*] Waiting for messages in order_queue. To exit press CTRL+C')

            # Pour s'assurer que le worker ne prend qu'un message à la fois (traitement équitable)
            channel.basic_qos(prefetch_count=1) 
            
            channel.basic_consume(queue='order_queue', on_message_callback=process_order_message)
            
            channel.start_consuming()

        except pika.exceptions.AMQPConnectionError as e:
            print(f"Connection to RabbitMQ failed: {e}. Retrying in {retry_interval} seconds...")
            if connection and not connection.is_closed:
                try:
                    connection.close()
                except Exception as close_exc:
                    print(f"Error closing connection: {close_exc}")
            time.sleep(retry_interval)
        except KeyboardInterrupt:
            print('Interrupted')
            if connection and not connection.is_closed:
                connection.close()
            break
        except Exception as e:
            print(f"An unexpected error occurred in main loop: {e}")
            if connection and not connection.is_closed:
                try:
                    connection.close()
                except Exception as close_exc:
                    print(f"Error closing connection: {close_exc}")
            time.sleep(retry_interval) # Attendre avant de réessayer en cas d'erreur inconnue

if __name__ == '__main__':
    # S'assurer que woody.py peut trouver la DB
    # Les variables d'environnement MYSQL_HOST etc. sont définies dans docker-compose pour ce worker
    main()

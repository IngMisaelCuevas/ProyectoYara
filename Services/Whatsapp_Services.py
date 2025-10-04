import requests
from config import Config

def EnviarMensajeWhatsApp(NumeroDestino, Mensaje):
    url = f"https://graph.facebook.com/v20.0/{Config.PHONE_NUMBER_ID}/messages"

    headers = {
        "Authorization": f"Bearer {Config.TOKEN}",
        "Content-Type": "application/json"
    }

    payload = {
        "messaging_product": "whatsapp",
        "to": NumeroDestino,
        "type": "text",
        "text": {"body": Mensaje}
    }

    response = requests.post(url, headers=headers, json=payload)

    return {
        "status_code": response.status_code,
        "response": response.json()
    }

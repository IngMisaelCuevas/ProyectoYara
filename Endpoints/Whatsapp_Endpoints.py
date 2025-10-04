from flask import Blueprint, request, jsonify
from Services.Whatsapp_Services import EnviarMensajeWhatsApp

whatsapp_bp = Blueprint("whatsapp", __name__)

@whatsapp_bp.route("/EnviarMensaje", methods=["POST"])
def send_message():
    data = request.json
    to = data.get("to")
    message = data.get("message")

    if not to or not message:
        return jsonify({"error": "Debes enviar 'to' y 'message'"}), 400

    result = EnviarMensajeWhatsApp(to, message)
    return jsonify(result)

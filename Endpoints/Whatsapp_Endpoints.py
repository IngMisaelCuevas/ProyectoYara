from flask import Blueprint, request, jsonify
from Services.Whatsapp_Services import EnviarMensajeWhatsApp
from Controllers.Whatsapp_Controller import insertar_conversacion

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


# ───────────── Recibir mensaje ─────────────
@whatsapp_bp.route("/RecibirMensaje", methods=["GET", "POST"])
def whatsapp_webhook():

    # Verificación del webhook
    if request.method == "GET":
        verify_token = "Yara"
        token = request.args.get("hub.verify_token")
        challenge = request.args.get("hub.challenge")

        if token == verify_token:
            return str(challenge)
        else:
            return "Error de verificación", 403

    if request.method == "POST":
        data = request.get_json()
        if data and "entry" in data:
            try:
                changes = data["entry"][0]["changes"][0]["value"]

                if "messages" in changes:
                    mensaje = changes["messages"][0]
                    numero_raw = mensaje["from"]
                    texto = mensaje["text"]["body"]

                    numero = numero_raw[:2] + numero_raw[3:]

                    # Obtener respuesta y registrar conversación
                    respuesta_texto = insertar_conversacion(numero, texto)

                    # Enviar respuesta al usuario
                    EnviarMensajeWhatsApp(numero, respuesta_texto)

            except Exception as e:
                print("Error al procesar mensaje:", e)

        return jsonify({"status": "ok"}), 200



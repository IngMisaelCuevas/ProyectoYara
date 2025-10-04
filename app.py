from flask import Flask
from config import Config
from Endpoints.Whatsapp_Endpoints import whatsapp_bp

app = Flask(__name__)
app.config.from_object(Config)

app.register_blueprint(whatsapp_bp, url_prefix="/Whatsapp")

if __name__ == "__main__":
    app.run(debug=True, port=5000)

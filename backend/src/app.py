# Importacion de librerias, paquetes y clases
from flask import Flask, request, jsonify, make_response
from flask_sqlalchemy import SQLAlchemy
from os import environ

# Instancia de la aplicación Flask
app = Flask(__name__)

# Configuración de la base de datos
app.config['SQLALCHEMY_DATABASE_URI'] = environ.get('DB_URL')
db = SQLAlchemy(app)

# Definicion de la tabla Productos
class Product(db.Model):
    # Nombre de la tabla
    __tablename__ = 'products'
    
    # Campos de la tabla
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), unique=True, nullable=False)
    description = db.Column(db.String(200), nullable=False)
    price = db.Column(db.Integer, nullable=False)

@app.get("/")
def index():
    return "Hello, World!"


# Para ejecutar el servidor, se debe ejecutar el comando: python src/app.py
# Para acceder a la aplicación, se debe acceder a la URL: http://0.0.0.0:80/
if __name__ == "__main__":
    app.run(debug=True, port=80, host="0.0.0.0")


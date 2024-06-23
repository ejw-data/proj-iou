from flask import Flask
from db_paths import path
from config import secret_key


def create_app():
    """
    Initiate Flask
    """
    app = Flask(__name__)
    app.config["SECRET_KEY"] = secret_key

    ENV = "prod"

    if ENV == "dev":
        app.debug = True
        app.config["SQLALCHEMY_DATABASE_URI"] = path["iou_tracker"]
        app.config["SQLALCHEMY_BINDS"] = {"iou_tracker": path["iou_tracker"]}
    elif ENV == "prod":
        app.debug = True
        app.config["SQLALCHEMY_DATABASE_URI"] = path['external']
        app.config["SQLALCHEMY_BINDS"] = {"iou_tracker": path['external']}
    else:
        print("Please select an environment:  developement or production.")

    app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

    return app

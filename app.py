# dependencies
from sqlalchemy_utils import database_exists
from flask_login import LoginManager
from site_routes import site
from api_routes import api
from setup import create_app
from models import db, Authentication
from db_paths import path


# create app
app = create_app()
app.register_blueprint(api)
app.register_blueprint(site)
app.app_context().push()

# connect to schema
db.init_app(app)

# flask_login setup
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = "login"


# used in site_routes.py, @site.route("/login")
@login_manager.user_loader
def load_user(login_id):
    """
    Identifies users who can login, used in conjunction with login_user()
    """
    return Authentication.query.get(int(login_id))


# generate database if it doesn't exist
if ~(database_exists(path["iou_tracker"])):
    db.create_all(bind_key=["iou_tracker"])

# run app
if __name__ == "__main__":
    app.run(debug=True)

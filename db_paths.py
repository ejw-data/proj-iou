from config import username, password, hostname, database, username_ext, password_ext, hostname_ext, database_ext
import os

# Databases
path = {
    "iou_tracker": f"postgresql+psycopg2://{username}:{password}@{hostname}/{database}",
    "external": os.environ.get("DATABASE_URL")
}

from config import username, password, hostname, database

# Databases
path = {
    "iou_tracker": f"postgresql+psycopg2://{username}:{password}@{hostname}/{database}"
    }

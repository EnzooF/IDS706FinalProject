from app import create_app
from swagger_ui import api_doc

app = create_app()
api_doc(app, config_path = "swagger.yml")
app.run(host = '0.0.0.0', port = 5001)
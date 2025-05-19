from some_app import app
if __name__ == "__main__":
    app.run()
def create_app():
    app = Flask(__name__)
    # ... ваша конфигурация
    return app

app = create_app()
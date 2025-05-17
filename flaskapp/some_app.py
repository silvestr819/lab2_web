from flask import Flask, render_template

app = Flask(__name__)

# Главная страница
@app.route("/")
def hello():
    return "<html><head></head><body>Hello World!</body></html>"

# Страница с передачей данных в шаблон
@app.route("/data_to")
def data_to():
    # Создаем данные для передачи в шаблон
    some_str = 'Hello my dear friends!'
    some_value = 10
    some_pars = {
        'user': 'Ivan',  # Раскомментируйте, если нужно использовать
        'color': 'red'   # эти параметры в шаблоне
    }
    
    # Передаем данные в шаблон
    return render_template(
        'simple.html',
        some_str=some_str,
        some_value=some_value,
        some_pars=some_pars  # Исправлено: передаем словарь, а не строку
    )

if __name__ == "__main__":
    app.run(host='127.0.0.1', port=5000, debug=True)  # Добавлен debug=True для разработки
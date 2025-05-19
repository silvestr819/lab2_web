#!/bin/bash
export CUDA_VISIBLE_DEVICES="-1"  # Отключает GPU

# Запускаем сервер на 0.0.0.0 (доступен и внутри контейнера, и извне)
gunicorn --bind 0.0.0.0:5000 --access-logfile - --error-logfile - wsgi:app & APP_PID=$!

# Даем серверу время на запуск
sleep 10

echo "Starting client..."
python3 client.py
APP_CODE=$?

# Даем клиенту время завершить работу
sleep 5

echo "Stopping server (PID $APP_PID)..."
kill -TERM $APP_PID
wait $APP_PID

echo "Client exit code: $APP_CODE"
exit $APP_CODE
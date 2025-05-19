#!/bin/bash
set -e  # Выход при ошибке
set -o pipefail

export CUDA_VISIBLE_DEVICES="-1"

# Запускаем сервер в фоне с логированием
gunicorn --bind 0.0.0.0:5000 --access-logfile gunicorn.log --error-logfile gunicorn.error.log wsgi:app & 
SERVER_PID=$!

# Функция для остановки сервера
cleanup() {
    echo "Stopping server (PID $SERVER_PID)..."
    kill -TERM $SERVER_PID 2>/dev/null || true
    wait $SERVER_PID 2>/dev/null || true
    echo "Server stopped"
}

# Гарантированная остановка при выходе
trap cleanup EXIT

# Ждем готовности сервера (до 30 сек)
for i in {1..30}; do
    if curl -sSf http://127.0.0.1:5000/healthcheck >/dev/null 2>&1; then
        echo "Server is ready!"
        break
    fi
    sleep 1
    echo "Waiting for server... ($i/30)"
done

# Запускаем клиент
echo "Starting client..."
python3 client.py
CLIENT_CODE=$?

# Выходим с кодом клиента
exit $CLIENT_CODE
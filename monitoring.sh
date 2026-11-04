#!/bin/bash

set -u

LOG_FILE="/var/log/monitoring.log"
PROCESS_NAME="test"
URL="https://test.com/monitoring/test/api"

# Проверка запущен ли процесс test
CURRENT_PROCESS_ID=$(pgrep -x "$PROCESS_NAME" || true)

if [ -z "$CURRENT_PROCESS_ID" ]; then
    exit 0
fi

# Стучимся на сервер
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 5 "$URL" || echo "000")

# Проверка ответа сервера
if [ "$HTTP_CODE" -ne 200 ]; then
    # Сервер недоступен или ответил ошибкой — пишем в лог
    echo "$(date '-%d-%m+%Y %H:%M:%S') - Сервер мониторинга недоступен. HTTP code: $HTTP_CODE" >> "$LOG_FILE"
fi

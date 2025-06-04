#!/bin/bash

# Функция для проверки доступности PostgreSQL
wait_for_postgres() {
    echo "Ожидание PostgreSQL..."
    until PGPASSWORD=$POSTGRES_PASSWORD psql -h "app-postgres" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c '\q' >/dev/null 2>&1; do
        echo "PostgreSQL недоступен, ждем 2 секунды..."
        sleep 2
    done
    echo "PostgreSQL готов!"
}

# Основной скрипт
set -e  # Прерывать выполнение при ошибках

wait_for_postgres

echo "Применение миграций..."
python manage.py migrate --noinput

echo "Проверка суперпользователя..."
if ! python manage.py shell -c "from django.contrib.auth import get_user_model; exit(0 if get_user_model().objects.filter(username='$DJANGO_SUPERUSER_USERNAME').exists() else 1)"; then
    echo "Создание суперпользователя..."
    python manage.py createsuperuser \
        --username "$DJANGO_SUPERUSER_USERNAME" \
        --email "$DJANGO_SUPERUSER_EMAIL" \
        --noinput || true
fi

echo "Сбор статических файлов..."
python manage.py collectstatic --noinput

echo "Запуск сервера Django..."
exec python manage.py runserver localhost:8000 #Для включения watch mode нужно убрать --noreload

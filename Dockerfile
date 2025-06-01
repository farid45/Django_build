FROM python:3


WORKDIR /MyProjectDjango

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libpq-dev \
    postgresql-client \
    gcc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Установка Python-зависимостей
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем все файлы проекта
COPY . .

# Делаем скрипт исполняемым
RUN chmod +x run.sh

ENV PYTHONUNBUFFERED=1
ENV DJANGO_SETTINGS_MODULE=store.settings

CMD ["./run.sh"]

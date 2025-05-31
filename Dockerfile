FROM python:3


# Устанавливает рабочий каталог контейнера — "app"
WORKDIR /MyProjectDjango

# Копирует все файлы из нашего локального проекта в контейнер
COPY ./requirements.txt .
COPY ./run.sh .

# Запускает команду pip install для всех библиотек, перечисленных в requirements.txt
RUN pip install -r requirements.txt

COPY . .
ENV PYTHONUNBUFFERED=1

CMD ["sh", "run.sh]

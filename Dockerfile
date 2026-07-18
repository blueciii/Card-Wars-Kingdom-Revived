FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=5000 \
    DB_FOLDER=/app/instance \
    BACKUP_FOLDER=/app/backup \
    LOGS_FOLDER=/app/data/persist/logs \
    GAMEDATA_FOLDER=/app/data/persist/gamedata

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt gunicorn

COPY . .

EXPOSE ${PORT}

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "4", "app:app"]
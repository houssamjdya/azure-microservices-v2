FROM python:3.11-slim

WORKDIR /app

COPY requirments.txt .
run pip install -no-cashe-dir -r requirments.txt

COPY app.py .

EXPOSE 5000

CMD [ "gunicorn", "--bind", "0.0.0.0:5000", "app:app" ]


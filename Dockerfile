FROM python:3.7-slim

WORKDIR /app

COPY api-server/requirements.txt .

COPY api-server/src/main.py .

RUN pip install -r requirements.txt

CMD ["python3", "main.py"]
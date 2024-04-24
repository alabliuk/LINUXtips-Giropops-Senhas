FROM ubuntu:22.04

WORKDIR /app

## Preparando o ambiente
RUN apt-get update && \
    apt-get install -y redis git python3-pip -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/alabliuk/LINUXtips-Giropops-Senhas.git
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

## Deploy aplicação
COPY . .
EXPOSE 80
ENV FLASK_RUN_HOST=0.0.0.0
ENV APP_VERSION 1.0
ENV REDIS_HOST=localhost

CMD ["bash", "-c", "service redis-server start && flask run --host 0.0.0.0"]
FROM python:3.12-alpine

RUN apk update && apk add curl

RUN pip install -U \
    pip \
    setuptools \
    wheel

WORKDIR /app

COPY requirements.txt ./
RUN pip install -r requirements.txt --no-cache-dir

COPY ./app /app

FROM python:3.7-alpine
MAINTAINER Nobuko Yano

ENV PYTHONUNBUFFERED 1
COPY ./requirements.txt /requirements.txt
RUN apk update
RUN apk add --upgrade --no-cache postgresql-client
RUN apk add --upgrade --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user

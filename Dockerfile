FROM python:3.12-alpine

ENV LOG_LEVEL=info
ENV APP_PORT=8000

WORKDIR /code/app
COPY ./requirements.txt /code/requirements.txt
COPY ./app /code/app
ENV PATH="/home/mack/.local/bin:${PATH}"

RUN adduser --disabled-password --gecos "MarstACK" mack
RUN chown -R mack:mack /code
USER mack
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

CMD ["/bin/sh", "-c", "uvicorn main:app --log-level ${LOG_LEVEL} --host 0.0.0.0 --port ${APP_PORT}"]

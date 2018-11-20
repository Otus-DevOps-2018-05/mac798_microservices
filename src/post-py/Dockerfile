FROM python:3.6.0-alpine
WORKDIR /app
COPY . /app
RUN apk --update add alpine-sdk && pip install -r /app/requirements.txt && apk del alpine-sdk
ENV POST_DATABASE_HOST post_db
ENV POST_DATABASE posts
CMD ["python3", "post_app.py"]

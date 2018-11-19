FROM alpine
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . $APP_HOME
RUN apk add alpine-sdk ruby ruby-dev ruby-bundler && bundle install && apk del ruby-dev alpine-sdk
ENV COMMENT_DATABASE_HOST comment_db
ENV COMMENT_DATABASE comments
CMD ["puma"]

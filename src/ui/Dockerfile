FROM alpine
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . $APP_HOME
RUN apk add alpine-sdk ruby ruby-dev ruby-bundler && bundle install && apk del ruby-dev alpine-sdk
ENV POST_SERVICE_HOST post
ENV POST_SERVICE_PORT 5000
ENV COMMENT_SERVICE_HOST comment
ENV COMMENT_SERVICE_PORT 9292
CMD ["puma"]

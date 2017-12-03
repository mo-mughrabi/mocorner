FROM ruby:2.4.1-alpine

ENV BUILD_PACKAGES bash curl-dev build-base nginx

RUN apk update && \
    apk upgrade && \
    apk add $BUILD_PACKAGES && \
    rm -rf /var/cache/apk/*

ENV APP_HOME /var/www
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc
RUN bundle install

COPY . $APP_HOME/
COPY .nginx/nginx-server.conf /etc/nginx/nginx.conf
COPY .nginx/nginx-site.conf /etc/nginx/conf.d/default.conf

RUN jekyll build

EXPOSE 8000

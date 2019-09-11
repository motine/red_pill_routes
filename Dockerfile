FROM ruby:2.6

MAINTAINER Tom Rothe <info@tomrothe.de>

RUN mkdir /app
WORKDIR /app

# we don't care about the size of this image, so no cache removal

# Gems
COPY ./Gemfile* /app/
RUN bundle install

VOLUME ["/app"]

CMD ["bundle", "exec", "ruby", "parser.rb"]

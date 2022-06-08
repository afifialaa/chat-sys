FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN gem install bundler -v 2.3.9
RUN gem install bundler
RUN bundle install
RUN rails webpacker:install
EXPOSE 3000 
CMD ["rails", "server", "-b", "0.0.0.0"]
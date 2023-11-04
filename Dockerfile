FROM ruby:2.7.7

RUN gem update --system

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN apt-get update && apt-get install -y \
    nodejs \
    npm \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && npm install -g yarn

RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
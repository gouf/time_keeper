FROM innocentzero/ruby:2.3.1

RUN apt-get update;apt-get install -y libpq-dev

WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

RUN mkdir -p /app
ADD . /app
WORKDIR /app

RUN RAILS_ENV=production bundle exec rake assets:precompile --trace
CMD ["rails","server","-b","0.0.0.0"]

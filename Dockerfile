FROM schlez/joe-rails-base
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install --jobs 5
ADD . /app
CMD ["./bin/entrypoint"]

# Base Image
FROM circleci/ruby:2.5.3
USER root

RUN apt-get update

# install chrome
RUN curl --silent --show-error --location --fail --retry 3 --output /tmp/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
     && (sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb || sudo apt-get -fy install)  \
     && rm -rf /tmp/google-chrome-stable_current_amd64.deb \
     && sudo sed -i 's|HERE/chrome"|HERE/chrome" --disable-setuid-sandbox --no-sandbox|g' \
          "/opt/google/chrome/google-chrome" \
     && google-chrome --version

# Make and switch to the /code directory which will hold the tests
RUN mkdir /code
WORKDIR /code

# Move over the Gemfile and Gemfile.lock before the rest so that we can cache the installed gems
ADD Gemfile /code/Gemfile
ADD Gemfile.lock /code/Gemfile.lock

# Upgrade to latest version of bundler
RUN gem install bundler

# Install all the gems specified by the gemfile
RUN bundle install

# Copy over the rest of the tests
ADD . /code

# Run the tests
# ENTRYPOINT bundle exec cucumber  --format json -o test.json
ENTRYPOINT bundle exec cucumber  --tags ${tag}

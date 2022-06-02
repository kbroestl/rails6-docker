FROM ruby:2.6.5

#Add yarn from repository
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install required package
# cribbed from https://github.com/timbru31/docker-ruby-node/blob/master/2.7/16/Dockerfile
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -\
&& apt-get update -qq \
&& apt-get install -qq --no-install-recommends \
apt-utils \
nodejs \
yarn \
nano

# Create directory docker-rails
RUN mkdir /testapp

# Change directory to docker-rails
WORKDIR /testapp

# Copy created Gemfile & Gemfile.lock to docker container
COPY Gemfile /testapp/Gemfile
COPY Gemfile.lock /testapp/Gemfile.lock

# Install dependencies
RUN bundle install
COPY . /testapp
EXPOSE 3000 3035
CMD ["rails", "server", "-b", "0.0.0.0"]
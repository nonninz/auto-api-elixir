FROM elixir:alpine

# prepare build dir
RUN mkdir /app
WORKDIR /app

# Can this be a very crude caching mechanism?
VOLUME /app/_build
VOLUME /app/deps

# This step installs all the build tools we'll need
#RUN apk add --update libressl-dev nodejs npm git build-base
RUN apk add --update git

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# This copies our app source code into the build container
COPY ./ ./

RUN mix do deps.get, deps.compile

# build project
RUN mix compile

# test
#RUN mix test

# credo
#RUN mix credo

# formatter
#RUN mix format --check-formatted

# dialyzer
#RUN mix dialyzer

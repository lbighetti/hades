# Hades

[![Build Status](https://img.shields.io/circleci/project/github/lbighetti/hades/master.svg)](https://circleci.com/gh/lbighetti/hades/tree/master) [![codecov](https://codecov.io/gh/lbighetti/hades/branch/master/graph/badge.svg)](https://codecov.io/gh/lbighetti/hades) [![Ebert](https://ebertapp.io/github/lbighetti/hades.svg)](https://ebertapp.io/github/lbighetti/hades) [![Join the chat at https://gitter.im/ex-hades/Lobby](https://badges.gitter.im/ex-hades/Lobby.svg)](https://gitter.im/ex-hades/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Hades is an open-source mentorship platform built with Elixir.

<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Hades](#hades)
	- [What is Hades](#what-is-hades)
	- [Contributing](#contributing)
	- [Starting Hades server](#starting-hades-server)
	- [Running Tests](#running-tests)
	- [Nanobox](#nanobox)
		- [Starting Hades server with Nanobox](#starting-hades-server-with-nanobox)
		- [Running Tests with Nanobox](#running-tests-with-nanobox)

<!-- /TOC -->

## What is Hades

We are building Hades as a open source platform for mentorships.

We believe in the power of mentors - having mentors but also being mentors.

We searched around and didn't find any free or open source solution that would fit this bill in a nice, clean and easy to use manner, so we decided to build one.

We invite you to join and leave your contribution as well.

This project is hosting the Elixir backend, you should also check out the frontend at:
* https://github.com/lbighetti/cerberus.

## Contributing

To start contributing you should:

* Read our [Code of Conduct](CODE_OF_CONDUCT.md)
* Have a look at our issues
* Comment that you wanna work on one of them
* Submit a PR
* Check feedback on the PR and adjust if needed

We would very much appreciate your help! :)

## Starting Hades server

To start Hades:

  * Install dependencies
    - [Elixir & Erlang](http://elixir-lang.github.io/install.html)
    - [Phoenix](https://hexdocs.pm/phoenix/installation.html)
    - [Postgres](https://www.postgresql.org/download/)
  * Add required local environment variables
    - `GUARDIAN_SECRET_KEY=G3RuCsdApqCOY8gWck97oWoj4m2aT87bblDRwEAsO4hJFHyiG9oKvN9OZcM/VkxM`
    - `SECRET_KEY_BASE=zA1N9iIAglu8XZHfk+ZXTcGedeeMuuaMOqB/h0EGcq7AkroSHoaqfYdet9kjOTcx`
  > Doesn't have to be these values, you can use `mix phx.gen.secret` to generate new ones if you want

  * Install dependencies with `mix deps.get`
  * Create your database with `mix ecto.create`
  * Migrate the database with `mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server`

Open your browser at `localhost:4000/api/hello`

## Running Tests

  * To run tests use `mix test`

## Nanobox

We are using Nanobox to facilitate development and deployment.
You can check out more about nanobox at https://nanobox.io/

It's a docker-based service which facilitates deployment in several VPS providers such as AWS, Digital Ocean, Scaleway and many more.

Another cool feature is that it replicates the production environment locally.

You can find instructions for using Nanobox below.

### Starting Hades server with Nanobox

To start Hades with nanobox:

  * [Install nanobox](https://docs.nanobox.io/install/)
  * Add required local environment variables `nanobox evar add local GUARDIAN_SECRET_KEY=G3RuCsdApqCOY8gWck97oWoj4m2aT87bblDRwEAsO4hJFHyiG9oKvN9OZcM/VkxM SECRET_KEY_BASE=zA1N9iIAglu8XZHfk+ZXTcGedeeMuuaMOqB/h0EGcq7AkroSHoaqfYdet9kjOTcx`
  > Doesn't have to be these values, you can use `mix phx.gen.secret` to generate new ones if you want
  * Install dependencies with `nanobox run mix deps.get`
  * Create your database with `nanobox run mix ecto.create`
  * Migrate the database with `nanobox run mix ecto.migrate`
  * Start Phoenix endpoint with `nanobox run mix phx.server`

You should get a message like:

> If you run a server, access it at >> 172.21.0.3

Then you can access the hello world endpoint at whatever ip shows up there in port 4000, /hello.

In this example, open your browser and type `172.21.0.3:4000/api/hello`

Alternatively, you can run `nanobox run` to get into the container, and then perform the other commands directly (except the `nanobox evar add local`, that one needs to be run from outside the container machine).


### Running Tests with Nanobox

* To run tests use `nanobox run mix test`

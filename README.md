# Hades

[![Join the chat at https://gitter.im/ex-hades/Lobby](https://badges.gitter.im/ex-hades/Lobby.svg)](https://gitter.im/ex-hades/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge) [![Build Status](https://img.shields.io/circleci/project/github/lbighetti/hades/master.svg)](https://circleci.com/gh/lbighetti/hades/tree/master) [![codecov](https://codecov.io/gh/lbighetti/hades/branch/master/graph/badge.svg)](https://codecov.io/gh/lbighetti/hades)

Hades is an open-source mentorship platform built with Elixir.

## Starting Hades server

To start Hades:

  * [Install nanobox](https://docs.nanobox.io/install/)
  * Install dependencies with `nanobox run mix deps.get`
  * Create your database with `nanobox run mix ecto.create`
  * Migrate the database with `nanobox run mix ecto.migrate`
  * Start Phoenix endpoint with `nanobox run mix phx.server`

You should get a message like:

> If you run a server, access it at >> 172.21.0.3

Then you can access the hello world endpoint at whatever ip shows up there in port 4000, /hello.

In this example, open your browser and type `172.21.0.3:4000/hello`


## Running Tests

* To run tests use `nanobox run mix test`

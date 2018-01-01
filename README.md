# Hades

[![Build Status](https://img.shields.io/circleci/project/github/lbighetti/hades/master.svg)](https://circleci.com/gh/lbighetti/hades/tree/master) [![codecov](https://codecov.io/gh/lbighetti/hades/branch/master/graph/badge.svg)](https://codecov.io/gh/lbighetti/hades) [![Ebert](https://ebertapp.io/github/lbighetti/hades.svg)](https://ebertapp.io/github/lbighetti/hades) [![Join the chat at https://gitter.im/ex-hades/Lobby](https://badges.gitter.im/ex-hades/Lobby.svg)](https://gitter.im/ex-hades/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Hades is an open-source mentorship platform built with Elixir.

## Starting Hades server

To start Hades:

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

In this example, open your browser and type `172.21.0.3:4000/hello`


## Running Tests

* To run tests use `nanobox run mix test`

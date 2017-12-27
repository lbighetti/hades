# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :hades,
  ecto_repos: [Hades.Repo]

# Configures the endpoint
config :hades, HadesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  render_errors: [view: HadesWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Hades.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :hades, Hades.Guardian,
  # The issuer of the token. Your application name/id
  issuer: "hades",
  # The secret key to use for the implementation module. This may be any resolvable value for Guardian.Config
  secret_key: System.get_env("GUARDIAN_SECRET_KEY")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

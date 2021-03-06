use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :hades, HadesWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :hades, Hades.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("DATA_DB_USER"),
  password: System.get_env("DATA_DB_PASS"),
  hostname: System.get_env("DATA_DB_HOST"),
  database: "hades_test",
  pool: Ecto.Adapters.SQL.Sandbox

# Reduce the number of bcrypt, or pbkdf2, rounds so it
# does not slow down the tests.
config :comeonin, :bcrypt_log_rounds, 4
config :comeonin, :pbkdf2_rounds, 1
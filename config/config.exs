# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :amaris_phoenix_lab,
  ecto_repos: [AmarisPhoenixLab.Repo]

# Configures the endpoint
config :amaris_phoenix_lab, AmarisPhoenixLabWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "glPfTiyKi3ZnWyQDQpFB5Oe8vJZ3XEpYP7b3mQ9+XxcHmZjnFZQPSaW7ItXx0DT2",
  render_errors: [view: AmarisPhoenixLabWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: AmarisPhoenixLab.PubSub,
  live_view: [signing_salt: "GC2RkTUl"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :amaris_phoenix_lab, :pow,
  user: AmarisPhoenixLab.Users.User,
  repo: AmarisPhoenixLab.Repo,
  web_module: AmarisPhoenixLabWeb

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

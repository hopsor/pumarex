# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :pumarex, ecto_repos: [Pumarex.Repo]

# Configures the endpoint
config :pumarex, Pumarex.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xBoTo/siGbkZnzxfew6rHvttDuUxlqvaUlLIRNFzkGeZNqnmCza3wteFs/vLlQgC",
  render_errors: [view: Pumarex.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Pumarex.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures Guardian
config :guardian, Guardian,
  # optional
  allowed_algos: ["HS512"],
  # optional
  verify_module: Guardian.JWT,
  issuer: "Pumarex",
  ttl: {30, :days},
  serializer: Pumarex.Web.GuardianSerializer

config :bcrypt_elixir, :log_rounds, 4

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

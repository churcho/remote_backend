# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :remote_backend,
  ecto_repos: [RemoteBackend.Repo],
  max_points: 100,
  max_user_seed: 10

# Configures the endpoint
config :remote_backend, RemoteBackendWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DO3jwcwJFZtldmGSw4hOageYKj3+d42X/3ZHmIg1dhJOTtxki6OxP/4JBSKv1WWz",
  render_errors: [view: RemoteBackendWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: RemoteBackend.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

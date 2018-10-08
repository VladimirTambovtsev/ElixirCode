# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :graphql_api,
  ecto_repos: [GraphqlApi.Repo]

# Configures the endpoint
config :graphql_api, GraphqlApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uk1YL68GA94WMCWOZei6aLiqsasvdC0WJJNtveU1HDzgShACvpzeYu3vNA1p7IAF",
  render_errors: [view: GraphqlApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: GraphqlApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Guardian config details for jwt
config :graphql_api, GraphqlApi.Guardian,
	issuer: "graphql_api",
	secret_key: "ueKK8VMr3hvPJFR55IzV7lePygcyxPlIFbfezVKahpjK3EZY8J7M9WnR59waYGfA"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

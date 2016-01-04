# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :mac_me, MacMe.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base:
    "tndr16dS7Hhk8+JJ0ca0+MaG0NXtaGe+L5CK0mjA6h6wBVojVUiosOpwTJTOGl8N",
  render_errors: [accepts: ~w(json)],
  pubsub: [name: MacMe.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :phoenix, :generators,
  migration: true,
  binary_id: false

config :dogma,
  rule_set: Dogma.RuleSet.All,
  exclude: [
    ~r(\Alib/vendor/),
  ]


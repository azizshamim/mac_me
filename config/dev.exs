use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :mac_me, MacMe.Endpoint,
  http: [port: 3000],
  debug_errors: true,
  code_reloader: true,
  cache_static_lookup: false,
  check_origin: false,
  watchers: []

# Watch static and templates for browser reloading.
config :mac_me, MacMe.Endpoint,
  live_reload: [
    patterns: [
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development.
# Do not configure such in production as keeping
# and calculating stacktraces is usually expensive.
config :phoenix, :stacktrace_depth, 20

# Custom Variables
config :mac_me, :device_poller, MacMe.DevicePoller.FakeArpPing
config :mac_me, :scanned_subnets, ['172.19.131.0/24']
config :mac_me, :poll_interval, 10000

config :mac_me, MacMe.Repo,
  adapter: Sqlite.Ecto,
  database: "local/mac_me_dev.sqlite3"

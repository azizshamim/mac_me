use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :mac_me, MacMe.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Set a higher stacktrace during test
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :mac_me, MacMe.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "mac_me_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :mac_me, :device_poller, MacMe.DevicePoller.FakeArpPing
config :mac_me, :scanned_subnets, ['172.19.131.0/24']
config :mac_me, :poll_interval, 10000

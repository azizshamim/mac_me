use Mix.Config

config :mac_me, MacMe.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: "somesite.thebikshed.io", port: 80],
  cache_static_manifest: "priv/static/manifest.json"

config :logger, level: :info

subnets = System.get_env("MACME_SUBNETS")

config :mac_me, :device_poller, MacMe.DevicePoller.ArpPing
config :mac_me, :scanned_subnets, subnets |> String.split ","
config :mac_me, :poll_interval, System.get_env("MACME_POLL_INTERVAL")

config :mac_me, :ldap,
  host: System.get_env("MACME_HOST"),
  port: System.get_env("MACME_PORT"),
  ssl: String.match?(String.get_env("MACME_SSL"), ~r/[tT]?(rue)?/),
  tls: String.match?(String.get_env("MACME_TLS"), ~r/[tT]?(rue)?/),
  bind_dn: System.get_env("MACME_BIND_DN"),
  password: System.get_env("MACME_PASSWORD"),
  devices_ou: System.get_env("MACME_DEVICES_OU")

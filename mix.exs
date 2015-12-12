defmodule MacMe.Mixfile do
  use Mix.Project

  def project do
    [app: :mac_me,
     version: "0.1.0",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     dialyzer: [plt_file: ".local.plt"]
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {MacMe, []},
     applications: [:phoenix, :cowboy, :logger, :phoenix_ecto, :postgrex,
                    :httpoison]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 1.0.2"},
     {:phoenix_ecto, "~> 1.1"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_html, "~> 2.1"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:cowboy, "~> 1.0"},
     {:exrm, "~> 0.18.1"},
     {:httpoison, "~> 0.7.4"},
     {:edeliver, ">= 1.1.1"},
     {:dialyxir, github: "jeremyjh/dialyxir", only: [:dev, :test]},
     {:dogma, github: "lpil/dogma", only: [:dev, :test]},
     {:faker, "~> 0.5", only: [:dev, :test]},
     {:mock, "~> 0.1.1", only: :test}]
  end
end

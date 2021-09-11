defmodule SnitchApi.Mixfile do
  use Mix.Project

  def project do
    [
      app: :snitch_api,
      version: "0.0.1",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.12.2",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {SnitchApi.Application, []},
      extra_applications: [:logger, :runtime_tools, :sentry]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4"},
      {:phoenix_pubsub, "~> 1.0"},
      {:gettext, "~> 0.11"},
      {:snitch_core, "~> 0.0.1", in_umbrella: true},
      {:plug_cowboy, "~> 2.0"},
      {:plug, "~> 1.12"},
      {:corsica, "~> 1.1"},
      {:uuid, "~> 1.1"},
      {:ja_serializer, "~> 0.16"},
      {:recase, "~> 0.7"},

      # Authentication
      {:guardian, "~> 2.2"},
      {:inflex, "~> 2.1"},

      # http client
      {:httpoison, "~> 1.8"},
      # {:snitch_payments, github: "aviacommerce/avia_payments", branch: "develop"},
      {:snitch_payments, github: "baldmountain/avia_payments", branch: "develop"},
      # {:snitch_payments, path: "/Users/gclements/work/avia_payments", branch: "develop"},

      # html parser
      {:floki, "~> 0.31"},
      {:jason, "~> 1.2"}
    ]
  end
end

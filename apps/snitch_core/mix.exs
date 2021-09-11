defmodule Snitch.Core.Mixfile do
  use Mix.Project

  @version "0.0.1"

  def project do
    [
      app: :snitch_core,
      version: @version,
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.12.2",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      package: package(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      docs: docs(),
      preferred_cli_env: [
        "test.multi": :test
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Snitch.Application, []},
      extra_applications: [:logger, :runtime_tools, :sentry, :cachex]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support", "priv/repo/seed"]
  defp elixirc_paths(_), do: ["lib", "priv/repo/seed", "priv/repo/demo", "priv/tasks"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:postgrex, "~> 0.15"},
      {:ecto, "~> 3.6"},
      {:bamboo, "~> 2.2"},
      {:combination, "~> 0.0.3"},
      {:bamboo_smtp, "~> 4.1"},
      {:bamboo_eex, github: "baldmountain/bamboo_eex"},
      {:ex_money, "~> 5.5"},
      {:rummage_ecto, "~> 2.0"},
      {:credo, "~> 1.5", only: :dev, runtime: false},
      {:credo_contrib, "~> 0.2", only: :dev, runtime: false},
      {:as_nested_set, "~> 3.4"},
      {:ecto_atom, github: "baldmountain/ecto_atom"},
      {:ecto_identifier, "~> 0.2"},
      {:ecto_autoslug_field, "~> 2.0"},

      # state machine
      {:beepbop, github: "baldmountain/beepbop", branch: "develop"},

      # time
      {:timex, "~> 3.7"},

      # auth
      {:comeonin, "~> 5.3"},
      {:argon2_elixir, "~> 2.4"},

      # countries etc
      {:ex_region, github: "oyeb/ex_region", branch: "embed-json"},

      # docs and tests
      {:ex_doc, "~> 0.25", only: :dev, runtime: false},
      {:excoveralls, "~> 0.14", only: :test},
      {:mox, "~> 1.0", only: :test},
      {:mock, "~> 0.3.7", only: :test},
      {:ex_machina, "~> 2.7", only: :test},
      {:dialyxir, "~> 1.1", only: [:dev], runtime: false},
      {:inch_ex, "~> 2.0", only: [:docs, :dev]},

      # csp
      {:aruspex, github: "oyeb/aruspex", branch: "tweaks"},

      # payments
      # {:snitch_payments, github: "aviacommerce/avia_payments", branch: "develop"},
      {:snitch_payments, github: "baldmountain/avia_payments", branch: "develop"},
      # {:snitch_payments, path: "/Users/gclements/work/avia_payments", branch: "develop"},

      # image uploading
      {:arc, "~> 0.11"},
      # {:arc_ecto, "~> 0.11"},
      {:arc_ecto, github: "baldmountain/arc_ecto"},
      {:ex_aws, "~> 2.2"},
      {:ex_aws_s3, "~> 2.3"},
      {:hackney, "~> 1.17"},
      {:sweet_xml, "~> 0.7"},
      {:plug_cowboy, "~> 2.0"},
      {:plug, "~> 1.12"},

      # unique id generator
      {:nanoid, "~> 2.0"},
      {:sentry, "~> 8.0"},
      {:jason, "~> 1.2"},
      {:nimble_csv, "~> 1.1"},

      # Multi tenancy
      {:triplex, "~> 1.3"},
      {:mariaex, "~> 0.9.1"},

      # xml
      {:xml_builder, "~> 2.2", override: true},

      # ecto_enum
      {:ecto_enum, "~> 1.4"},

      # Elastic search integration
      {:elasticsearch, "~> 1.0"},

      # Caching
      {:cachex, "~> 3.4"}
    ]
  end

  defp package do
    [
      contributors: [],
      maintainers: [],
      licenses: [],
      links: %{
        "GitHub" => "https://github.com/aviabird/snitch",
        "Readme" => "https://github.com/aviabird/snitch/blob/v#{@version}/README.md"
        # "Changelog" => "https://github.com/aviabird/snitch/blob/v#{@version}/CHANGELOG.md"
      }
    ]
  end

  defp docs do
    [
      extras: ~w(README.md),
      main: "readme",
      source_ref: "v#{@version}",
      source_url: "https://github.com/aviabird/snitch",
      groups_for_modules: groups_for_modules()
    ]
  end

  defp groups_for_modules do
    [
      Schema: ~r/^Snitch.Data.Schema.?/,
      Models: ~r/^Snitch.Data.Model.?/,
      Domain: ~r/^Snitch.Domain.?/
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.load.demo": "run priv/repo/demo/demo.exs",
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seed/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "ecto.rebuild": ["ecto.drop", "ecto.create --quiet", "ecto.migrate"],
      "ecto.load.demo": ["run priv/repo/demo/demo.exs"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"],
      "test.multi": [
        "ecto.drop --quiet",
        "ecto.create --quiet",
        "ecto.migrate",
        "run test/support/multitenancy_setup.exs amazon",
        "test"
      ],
      "seed.multi": [
        "run test/support/multitenancy_setup.exs amazon",
        "run priv/repo/seed/seeds.exs"
      ]
    ]
  end
end

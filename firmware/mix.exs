defmodule Firmware.MixProject do
  use Mix.Project

  @all_targets [:rpi0, :rpi3, :rpi]
  @app :firmware

  def project do
    [
      app: @app,
      version: "0.1.0",
      elixir: "~> 1.9",
      archives: [nerves_bootstrap: "~> 1.9"],
      start_permanent: Mix.env() == :prod,
      build_embedded: Mix.target() != :host,
      releases: [{@app, release()}],
      preferred_cli_target: [run: :host, test: :host],
      deps: deps()
    ]
  end

  def release do
    [
      overwrite: true,
      cookie: "#{@app}_cookie",
      include_erts: &Nerves.Release.erts/0,
      steps: [&Nerves.Release.init/1, :assemble],
      strip_beams: Mix.env() == :prod
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Firmware.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nerves, "~> 1.9", runtime: false},
      {:shoehorn, "~> 0.9"},
      {:ring_logger, "~> 0.8"},
      {:toolshed, "~> 0.2.13"},

      {:nerves_runtime, "~> 0.13", targets: @all_targets},
      {:nerves_pack, "~> 0.7.0", targets: @all_targets},
      {:delux, "~> 0.4.1", targets: @all_targets},

      {:ui, path: "../ui", env: Mix.env()},

      {:nerves_system_rpi, "~> 1.21.1", runtime: false, targets: :rpi},
      {:nerves_system_rpi0, "~> 1.21.1", runtime: false, targets: :rpi0},
      {:nerves_system_rpi2, "~> 1.21.1", runtime: false, targets: :rpi2},
      {:nerves_system_rpi3, "~> 1.21.1", runtime: false, targets: :rpi3},
      {:nerves_system_rpi4, "~> 1.21.1", runtime: false, targets: :rpi4},
      {:nerves_system_bbb, "~> 2.3", runtime: false, targets: :bbb},
      {:nerves_system_x86_64, "~> 1.21.1", runtime: false, targets: :x86_64}
    ]
  end
end

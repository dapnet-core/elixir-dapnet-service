defmodule DapnetService.MixProject do
  use Mix.Project

  def project do
    [
      app: :dapnet_service,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:httpoison],
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, "~> 1.0"},
      {:httpoison, "~> 1.1.1"},
      {:comeonin, "~> 4.0"},
      {:bcrypt_elixir, "~> 1.0"},
      {:couchdb, github: "7h0ma5/elixir-couchdb"},
    ]
  end
end

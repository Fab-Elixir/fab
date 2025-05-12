defmodule Fab.MixProject do
  use Mix.Project

  def project do
    [
      app: :fab,
      description: "Fab is a lightweight Elixir library for generating fake data",
      version: "1.0.1",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:dialyxir, "== 1.4.5", only: :dev, runtime: false},
      {:ex_doc, "== 0.38.0", only: :dev, runtime: false}
    ]
  end

  defp elixirc_paths(:test) do
    ["lib/", "test/support"]
  end

  defp elixirc_paths(_env) do
    ["lib/"]
  end

  defp package do
    %{
      authors: ["Anthony Smith"],
      licenses: ["MIT"],
      links: %{
        GitHub: "https://github.com/Fab-Elixir/fab"
      }
    }
  end
end

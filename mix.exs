defmodule Fab.MixProject do
  use Mix.Project

  def project do
    [
      app: :fab,
      version: "0.0.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:eex, :logger]
    ]
  end

  defp deps do
    [
      {:dialyxir, "== 1.4.5", only: :dev, runtime: false},
      {:ex_doc, "== 0.37.3", only: :dev, runtime: false}
    ]
  end
end

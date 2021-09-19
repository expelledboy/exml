defmodule Exml.Mixfile do
  use Mix.Project

  @description "Most simple Elixir wrapper for xmerl xpath"

  def project do
    [
      app: :exml,
      version: "0.1.2",
      elixir: "~> 1.0",
      description: @description,
      package: package(),
      deps: deps(),
      dialyzer: dialyzer()
    ]
  end

  def application do
    [applications: [:logger, :xmerl]]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*"],
      licenses: ["Apache 2.0"],
      maintainers: ["expelledboy"],
      links: %{"GitHub" => "https://github.com/expelledboy/exml"}
    ]
  end

  defp dialyzer do
    [
      plt_core_path: "priv/plts",
      plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
    ]
  end
end

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
      deps: deps()
    ]
  end

  def application do
    [applications: [:logger, :xmerl]]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.18.3", only: :dev, runtime: false},
      {:credo, "~> 0.9.2", only: [:dev, :test], runtime: false}
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
end

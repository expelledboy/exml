defmodule Exml.Mixfile do
  use Mix.Project

  def project do
    [app: :exml,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  def application do
    [applications: [:logger, :xmerl]]
  end

  defp deps do
    []
  end
end

defmodule Exml.Mixfile do
  use Mix.Project

  def project do
    [app: :exml,
     version: "0.0.1",
     elixir: "~> 1.0",
     description: description,
     package: package,
     deps: deps]
  end

  def application do
    [applications: [:logger, :xmerl]]
  end

  defp deps do
    []
  end

  defp description do
    """
    Most simple Elixir wrapper for xmerl xpath 
    """
  end

  defp package do
    [
      files: ["lib", "priv", "mix.exs", "README*"],
      maintainers: ["expelledboy"],
      links: %{"GitHub" => "https://github.com/expelledboy/exml"},
    ]
  end
end



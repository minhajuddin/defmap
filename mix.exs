defmodule Defmap.Mixfile do
  use Mix.Project
  @description  "Embed your map into a module for easier/faster lookup"

  def project do
    [app: :defmap,
     name: "defmap",
     description: @description,
     package: package,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    []
  end

  defp package do
    [description: @description,
     files: ["lib", "config", "mix.exs", "README.md"],
     maintainers: ["Khaja Minhajuddin"],
     licenses: ["MIT"],
     links: %{github: "https://github.com/minhajuddin/defmap"}]
  end
end

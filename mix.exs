defmodule Hippy.MixProject do
  use Mix.Project

  def project do
    [
      app: :hippy,
      version: "0.4.1-dev",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      name: "Hippy",
      source_url: "https://github.com/mpichette/hippy"
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Hippy.Application, []}
    ]
  end

  defp deps do
    [
      {:finch, "~> 0.21"},
      {:ex_doc, "~> 0.23", only: :dev}
    ]
  end

  defp description do
    """
    Hippy is an Internet Printing Protocol (IPP) client implementation in Elixir for performing
    distributed printing over HTTP. It can be used with CUPS or network printers supporting IPP.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      organization: "jackpocket",
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/jackpocket/hippy"}
    ]
  end
end

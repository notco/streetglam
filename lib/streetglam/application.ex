defmodule Streetglam.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      StreetglamWeb.Telemetry,
      Streetglam.Repo,
      {DNSCluster, query: Application.get_env(:streetglam, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Streetglam.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Streetglam.Finch},
      # Start a worker by calling: Streetglam.Worker.start_link(arg)
      # {Streetglam.Worker, arg},
      # Start to serve requests, typically the last entry
      StreetglamWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Streetglam.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    StreetglamWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

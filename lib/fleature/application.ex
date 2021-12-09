defmodule Fleature.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Fleature.Repo,
      # Start the Telemetry supervisor
      FleatureWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Fleature.PubSub},
      # Start the Endpoint (http/https)
      FleatureWeb.Endpoint
      # Start a worker by calling: Fleature.Worker.start_link(arg)
      # {Fleature.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Fleature.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FleatureWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

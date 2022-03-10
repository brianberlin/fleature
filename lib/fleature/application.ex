defmodule Fleature.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Fleature.PromEx,
      Fleature.Repo,
      FleatureWeb.Telemetry,
      {Phoenix.PubSub, name: Fleature.PubSub},
      FleatureWeb.Endpoint,
      {Oban, Application.fetch_env!(:fleature, Oban)}
    ]

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

defmodule FleatureWeb.FeatureFlagsLive.Create do
  @moduledoc false
  use FleatureWeb, :live_component

  alias Fleature.FeatureFlags
  alias Fleature.Schemas.FeatureFlag

  def update(assigns, socket) do
    changeset =
      FeatureFlag.insert_changeset(%FeatureFlag{}, %{
        environment_id: assigns.environment.id
      })

    socket =
      socket
      |> assign(:changeset, changeset)
      |> assign(:environment, assigns.environment)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.h1>Create a Feature Flag</.h1>
      <.form class="feature-flag-form" let={f} for={@changeset} phx-change="validate" phx-submit="save" phx-target={@myself}>
        <.text_input f={f} key={:name} />
        <.hidden_input f={f} key={:environment_id} value={@environment.id} />
        <.submit_button>Save</.submit_button>
      </.form>
    </div>
    """
  end

  def handle_event("validate", %{"feature_flag" => params}, socket) do
    changeset = FeatureFlag.insert_changeset(%FeatureFlag{}, params)
    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"feature_flag" => params}, socket) do
    case FeatureFlags.insert_feature_flag(params) do
      {:ok, _feature_flag} ->
        path = Routes.environments_path(FleatureWeb.Endpoint, :view, socket.assigns.environment)

        {:noreply, push_redirect(socket, to: path)}

      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end

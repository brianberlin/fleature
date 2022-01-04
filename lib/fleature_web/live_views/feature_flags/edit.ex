defmodule FleatureWeb.FeatureFlagsLive.Edit do
  @moduledoc false
  use FleatureWeb, :live_component

  alias Fleature.FeatureFlags
  alias Fleature.Schemas.FeatureFlag

  def update(assigns, socket) do
    changeset = Ecto.Changeset.change(assigns.feature_flag, %{})

    socket =
      socket
      |> assign(:changeset, changeset)
      |> assign(:user, assigns.user)
      |> assign(:feature_flag, assigns.feature_flag)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.form_container>
        <:header>
          <.h2><%= @feature_flag.name %></.h2>
        </:header>
        <:body>
          <.form class="feature_flag-form" let={f} for={@changeset} phx-change="validate" phx-submit="save" phx-target={@myself}>
            <.text_input f={f} key={:name} />
            <.submit_button>Save</.submit_button>
          </.form>
        </:body>
      </.form_container>
    </div>
    """
  end

  def handle_event("validate", %{"feature_flag" => params}, socket) do
    changeset = FeatureFlag.update_changeset(socket.assigns.feature_flag, params)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"feature_flag" => params}, socket) do
    case FeatureFlags.update_feature_flag(socket.assigns.feature_flag, params) do
      {:ok, feature_flag} ->
        path = Routes.projects_path(FleatureWeb.Endpoint, :view, feature_flag.project_id)
        {:noreply, push_redirect(socket, to: path)}

      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end

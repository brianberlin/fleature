defmodule FleatureWeb.EnvironmentsLive.View do
  @moduledoc false
  use FleatureWeb, :live_component

  alias Fleature.FeatureFlags
  alias Fleature.Schemas.FeatureFlag

  def update(assigns, socket) do
    socket =
      socket
      |> assign(:environment, assigns.environment)
      |> assign_feature_flags()

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.h1><%= @environment.name %></.h1>
      <.breadcrumbs environment={@environment} />
      <.h1>Feature Flags</.h1>
      <.ul>
        <%= for feature_flag <- @feature_flags do %>
          <.li>
            <%= feature_flag.name %>
            <.form class="feature-flag-form" let={f} for={make_changeset(feature_flag)} phx-change="save" phx-target={@myself}>
              <.hidden_input f={f} key={:id} />
              <.checkbox_input f={f} key={:status} />
            </.form>
          </.li>
        <% end %>
      </.ul>
      <.a
        class="create-feature_flag"
        path={Routes.feature_flags_path(FleatureWeb.Endpoint, :create, @environment)}
      >Create Feature Flag</.a>
    </div>
    """
  end

  def handle_event("save", %{"feature_flag" => params}, socket) do
    feature_flag = FeatureFlags.get_feature_flag(id: params["id"])
    {:ok, _feature_flag} = FeatureFlags.update_feature_flag_status(feature_flag, params)
    {:noreply, assign_feature_flags(socket)}
  end

  defp assign_feature_flags(socket) do
    feature_flags = FeatureFlags.list_feature_flags(environment_id: socket.assigns.environment.id)
    assign(socket, :feature_flags, feature_flags)
  end

  def make_changeset(feature_flag) do
    FeatureFlag.status_changeset(feature_flag, %{})
  end
end

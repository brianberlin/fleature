defmodule FleatureWeb.EnvironmentsLive.View do
  @moduledoc false
  use FleatureWeb, :live_component

  alias Fleature.FeatureFlags

  def update(assigns, socket) do
    feature_flags = FeatureFlags.list_feature_flags(environment_id: assigns.environment.id)

    socket =
      socket
      |> assign(:environment, assigns.environment)
      |> assign(:feature_flags, feature_flags)

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
            <.a path={""}>
              <%= feature_flag.name %>
            </.a>
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
end

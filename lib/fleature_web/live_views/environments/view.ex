defmodule FleatureWeb.EnvironmentsLive.View do
  @moduledoc false
  use FleatureWeb, :live_component

  alias Fleature.EnvironmentTokens
  alias Fleature.FeatureFlags
  alias Fleature.Schemas.FeatureFlag

  def update(assigns, socket) do
    socket =
      socket
      |> assign(:environment, assigns.environment)
      |> assign(:user, assigns.user)
      |> assign_feature_flags()
      |> assign_environment_tokens()

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.container>
        <.header
          title="Feature Flags"
          back={Routes.projects_path(FleatureWeb.Endpoint, :view, @environment.project)}
          user={@user}
        >
          <:breadcrumb title="Home" to={Routes.home_path(FleatureWeb.Endpoint, :index)} />
          <:breadcrumb title={@environment.organization.name} to={Routes.organizations_path(FleatureWeb.Endpoint, :view, @environment.organization)} />
          <:breadcrumb title={@environment.project.name} to={Routes.projects_path(FleatureWeb.Endpoint, :view, @environment.project)} />
          <:breadcrumb title={@environment.name} />
          <.link patch button to={Routes.feature_flags_path(FleatureWeb.Endpoint, :create, @environment)}>Create Feature Flag</.link>
        </.header>

        <.table rows={@feature_flags}>
          <:col let={feature_flag} label="Name">
            <%= feature_flag.name %>
          </:col>
          <:col let={feature_flag} label="Status">
            <.form class="feature-flag-form" let={f} for={make_changeset(feature_flag)} phx-change="save" phx-target={@myself}>
              <.hidden_input f={f} key={:id} />
              <.toggle_input f={f} key={:status} />
            </.form>
          </:col>
          <:col let={feature_flag} label="Actions" class="w-2/12">
            <.link
              button secondary small
              class={"delete_feature_flag_#{feature_flag.id}"}
              click="delete_feature_flag"
              id={feature_flag.id}
              target={@myself}
            >Delete</.link>
          </:col>
        </.table>

        <div class="mt-8 md:flex md:items-center md:justify-between">
          <div class="flex-1 min-w-0">
          <.h2 class="mt-0">Environment Tokens</.h2>
          </div>
          <div class="mt-4 flex-shrink-0 flex md:mt-0 md:ml-4">
            <.link
              button
              id="create_environment_token"
              click="new_environment_token"
              class="create_environment_token"
              target={@myself}
            >Generate Environment Token</.link>
          </div>
        </div>
        <.table rows={@environment_tokens}>
          <:col let={environment_token} label="Client Id"><%= environment_token.client_id %></:col>
          <:col let={environment_token} label="Client Secret"><%= environment_token.client_secret %></:col>
          <:col let={environment_token} label="Actions" class="w-2/12">
            <.link
              button secondary small
              class="delete_environment_token"
              click="delete_environment_token"
              id={environment_token.id}
              target={@myself}
            >Delete</.link>
          </:col>
        </.table>
      </.container>
    </div>
    """
  end

  def handle_event("delete_environment_token", %{"id" => id}, socket) do
    environment_token = EnvironmentTokens.get_environment_token(id: id)
    EnvironmentTokens.delete_environment_token(environment_token)

    {:noreply, assign_environment_tokens(socket)}
  end

  def handle_event("delete_feature_flag", %{"id" => id}, socket) do
    feature_flag = FeatureFlags.get_feature_flag(id: id)
    FeatureFlags.delete_feature_flag(feature_flag)

    {:noreply, assign_feature_flags(socket)}
  end

  def handle_event(
        "new_environment_token",
        _params,
        %{assigns: %{environment_tokens: environment_tokens}} = socket
      ) do
    client_id = 16 |> :crypto.strong_rand_bytes() |> Base.encode64()
    client_secret = 32 |> :crypto.strong_rand_bytes() |> Base.encode64()
    hashed_client_secret = Bcrypt.hash_pwd_salt(client_secret)

    attrs = %{
      client_id: client_id,
      hashed_client_secret: hashed_client_secret,
      environment_id: socket.assigns.environment.id,
      user_id: socket.assigns.user.id
    }

    {:ok, environment_token} = EnvironmentTokens.insert_environment_token(attrs)
    environment_token = Map.put(environment_token, :client_secret, client_secret)

    {:noreply, assign(socket, :environment_tokens, environment_tokens ++ [environment_token])}
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

  defp assign_environment_tokens(socket) do
    environment_tokens =
      EnvironmentTokens.list_environment_tokens(environment_id: socket.assigns.environment.id)

    assign(socket, :environment_tokens, environment_tokens)
  end

  def make_changeset(feature_flag) do
    FeatureFlag.status_changeset(feature_flag, %{})
  end
end

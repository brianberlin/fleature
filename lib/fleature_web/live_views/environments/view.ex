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
      |> assign(:user_id, assigns.user_id)
      |> assign(:client_id, nil)
      |> assign(:client_secret, nil)
      |> assign_feature_flags()
      |> assign_environment_tokens()

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.h1><%= @environment.name %></.h1>
      <.breadcrumbs environment={@environment} />
      <.h2>Environment Tokens</.h2>
      <%= if not is_nil(@client_id) and not is_nil(@client_secret) do %>
        <pre><code>
          New Environment Client Id/Secret
          ----
          Client Id: <%= @client_id %>
          Client Secret: <%= @client_secret %>
        </code></pre>
      <% end %>
      <.ul>
        <%= for environment_token <- @environment_tokens do %>
          <.li>
            <%= environment_token.client_id %>
            <a
              href="#"
              class="delete_environment_token"
              phx-click="delete_environment_token"
              phx-value-id={environment_token.id}
              phx-target={@myself}
            >Delete</a>
          </.li>
        <% end %>
      </.ul>
      <a
        class="create_environment_token"
        phx-click="new_environment_token"
        phx-target={@myself}
      >Generate Environment Token</a>
      <.h2>Feature Flags</.h2>
      <.ul>
        <%= for feature_flag <- @feature_flags do %>
          <.li>
            <.form class="feature-flag-form" let={f} for={make_changeset(feature_flag)} phx-change="save" phx-target={@myself}>
              <.hidden_input f={f} key={:id} />
              <label>
                <%= feature_flag.name %>
                <.checkbox_input f={f} key={:status} />
              </label>
            </.form>
          </.li>
        <% end %>
      </.ul>
      <.patch_link
        class="create-feature_flag"
        to={Routes.feature_flags_path(FleatureWeb.Endpoint, :create, @environment)}
      >Create Feature Flag</.patch_link>
    </div>
    """
  end

  def handle_event("delete_environment_token", %{"id" => id}, socket) do
    environment_token = EnvironmentTokens.get_environment_token(id: id)
    EnvironmentTokens.delete_environment_token(environment_token)

    {:noreply, assign_environment_tokens(socket)}
  end

  def handle_event("new_environment_token", _params, socket) do
    client_id = 16 |> :crypto.strong_rand_bytes() |> Base.encode64()
    client_secret = 32 |> :crypto.strong_rand_bytes() |> Base.encode64()
    hashed_client_secret = Bcrypt.hash_pwd_salt(client_secret)

    attrs = %{
      client_id: client_id,
      hashed_client_secret: hashed_client_secret,
      environment_id: socket.assigns.environment.id,
      user_id: socket.assigns.user_id
    }

    {:ok, _environment_token} = EnvironmentTokens.insert_environment_token(attrs)

    socket =
      socket
      |> assign(:client_id, client_id)
      |> assign(:client_secret, client_secret)
      |> assign_environment_tokens()

    {:noreply, socket}
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

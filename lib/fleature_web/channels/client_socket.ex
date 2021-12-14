defmodule FleatureWeb.ClientSocket do
  use Phoenix.Socket

  alias Fleature.EnvironmentTokens

  # A Socket handler
  #
  # It's possible to control the websocket connection and
  # assign values that can be accessed by your channel topics.

  ## Channels

  channel "client:*", FleatureWeb.ClientChannel

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  @impl true
  def connect(
        %{"client_id" => client_id, "client_secret" => client_secret},
        socket,
        _connect_info
      ) do
    environment_token = EnvironmentTokens.get_environment_token(client_id: client_id)

    if Bcrypt.verify_pass(client_secret, environment_token.hashed_client_secret) do
      {:ok, assign(socket, :client_id, client_id)}
    else
      :error
    end
  end

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     Elixir.FleatureWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  @impl true
  def id(%{assigns: %{client_id: client_id}}), do: "client:" <> client_id
  def id(_socket), do: nil
end

defmodule FleatureWeb.ClientChannelTest do
  use FleatureWeb.ChannelCase
  use Oban.Testing, repo: Fleature.Repo

  setup do
    environment_token = insert(:environment_token)
    topic = "client:" <> environment_token.client_id

    {:ok, _, socket} =
      socket(FleatureWeb.ClientSocket, topic, %{client_id: environment_token.client_id})
      |> subscribe_and_join(FleatureWeb.ClientChannel, topic, %{})

    {:ok, socket: socket, environment_token: environment_token}
  end

  test "update_all", %{socket: socket, environment_token: environment_token} do
    feature_flag = insert(:feature_flag, environment: environment_token.environment)
    send(socket.channel_pid, :update_all)
    feature_flags = %{feature_flag.name => feature_flag.status}
    assert_push("update_all", ^feature_flags)
  end

  test "update_one", %{socket: socket, environment_token: environment_token} do
    feature_flag = insert(:feature_flag, environment: environment_token.environment)
    send(socket.channel_pid, {:update_one, feature_flag.name, feature_flag.status})
    feature_flags = %{feature_flag.name => feature_flag.status}
    assert_push("update_one", ^feature_flags)
  end
end

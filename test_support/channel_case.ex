defmodule FleatureWeb.ChannelCase do
  @moduledoc """
  This module defines the test case to be used by
  channel tests.

  Such tests rely on `Phoenix.ChannelTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use FleatureWeb.ChannelCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate
  import Fleature.Factory
  import Phoenix.ChannelTest
  @endpoint FleatureWeb.Endpoint

  using do
    quote do
      # Import conveniences for testing with channels
      import Phoenix.ChannelTest
      import FleatureWeb.ChannelCase
      import Fleature.DataCase
      import Fleature.Factory

      # The default endpoint for testing
      @endpoint FleatureWeb.Endpoint
    end
  end

  setup tags do
    pid = Ecto.Adapters.SQL.Sandbox.start_owner!(Fleature.Repo, shared: not tags[:async])
    on_exit(fn -> Ecto.Adapters.SQL.Sandbox.stop_owner(pid) end)
    :ok
  end
end

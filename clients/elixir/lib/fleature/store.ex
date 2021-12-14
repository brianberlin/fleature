defmodule Fleature.Store do
  use GenServer

  def start_link(_) do
    initial_state = Application.get_env(:fleature, :feature_flags)
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def enabled?(name) do
    GenServer.call(__MODULE__, {:enabled?, name})
  end

  def update(feature_flags) do
    GenServer.cast(__MODULE__, {:update, feature_flags})
  end

  def handle_cast({:update, new_state}, _state) do
    {:noreply, new_state}
  end

  def handle_call({:enabled?, name}, _from, state) do
    {:reply, Map.get(state, name, false), state}
  end
end

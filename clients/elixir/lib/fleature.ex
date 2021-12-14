defmodule Fleature do
  def enabled?(name) do
    Fleature.Store.enabled?(name)
  end

  def subscribe(name) do
    Phoenix.PubSub.subscribe(Fleature.PubSub, "fleature:feature_flag:" <> name)
  end
end

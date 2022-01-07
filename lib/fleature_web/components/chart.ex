defmodule FleatureWeb.Components.Chart do
  @moduledoc false
  use FleatureWeb, :live_component

  alias VegaLite, as: Vl

  def update_chart_size(id, width) do
    usages = Fleature.FeatureFlagUsages.data_feature_flag_usages(id)

    spec =
      Vl.new(width: width - 220, height: 400, background: "transparent")
      |> Vl.mark(:line)
      |> Vl.encode_field(:x, "Time", type: :temporal)
      |> Vl.encode_field(:y, "Count", type: :quantitative)
      |> Vl.encode_field(:color, "Feature Flags", type: :ordinal)
      |> Vl.data_from_series(usages)
      |> Vl.to_spec()

    send_update(FleatureWeb.Components.Chart, id: String.to_integer(id), width: width, spec: spec)
  end

  @impl true
  def update(assigns, socket) do
    socket = assign(socket, id: assigns.id)

    # Send the specification object to the hook, where it gets
    # rendered using the client side Vega-Lite package
    {:ok, push_event(socket, "vega_lite:#{socket.assigns.id}:init", %{"spec" => assigns.spec})}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div
      id={"vega-lite-#{@id}"}
      phx-hook="Chart"
      phx-update="ignore"
      data-id={@id}
      class="flex justify-center mt-5 p-5 bg-white shadow overflow-hidden border-b border-gray-200 sm:rounded-lg"
    />
    """
  end
end

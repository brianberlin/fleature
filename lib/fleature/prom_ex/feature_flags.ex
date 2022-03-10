defmodule Fleature.PromEx.FeatureFlagsPlugin do
  @moduledoc false
  use PromEx.Plugin

  @impl true
  def event_metrics(_opts) do
    Event.build(
      :fleature_feature_flag_metrics,
      [
        counter(
          [:fleature, :feature_flags, :broadcast, :counter],
          description: "Counter",
          event_name: [:fleature, :feature_flags, :broadcast]
        ),
        distribution(
          [:fleature, :feature_flags, :broadcast, :duration, :milliseconds],
          event_name: [:fleature, :feature_flags, :broadcast, :stop],
          measurement: :duration,
          unit: {:native, :millisecond},
          reporter_options: [
            buckets: [1, 3, 6, 9, 12, 15]
          ]
        )
      ]
    )
  end
end

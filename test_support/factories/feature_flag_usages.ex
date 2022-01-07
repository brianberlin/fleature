defmodule Fleature.FeatureFlagUsageFactory do
  defmacro __using__(_opts) do
    quote do
      def feature_flag_usage_factory do
        %Fleature.Schemas.FeatureFlagUsage{
          count: 10,
          recorded_at: DateTime.utc_now(),
          environment: build(:environment),
          feature_flag: build(:feature_flag)
        }
      end
    end
  end
end

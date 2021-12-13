defmodule Fleature.FeatureFlagFactory do
  defmacro __using__(_opts) do
    quote do
      def feature_flag_factory do
        %Fleature.Schemas.FeatureFlag{
          name: sequence(:name, &"name-#{&1}"),
          status: false,
          environment: build(:environment)
        }
      end
    end
  end
end

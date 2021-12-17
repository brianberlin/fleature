defmodule Fleature.FeatureFlagFactory do
  defmacro __using__(_opts) do
    quote do
      def feature_flag_factory do
        name = for _ <- 1..10, into: "", do: <<Enum.random('abcdefghijklmnopqrstuvwxyz')>>
        %Fleature.Schemas.FeatureFlag{
          name: name,
          status: false,
          environment: build(:environment)
        }
      end
    end
  end
end

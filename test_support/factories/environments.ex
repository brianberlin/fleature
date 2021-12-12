defmodule Fleature.EnvironmentFactory do
  defmacro __using__(_opts) do
    quote do
      def environment_factory do
        %Fleature.Schemas.Environment{
          name: sequence(:name, &"name-#{&1}"),
          project: build(:project)
        }
      end
    end
  end
end

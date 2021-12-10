defmodule Fleature.ProjectFactory do
  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %Fleature.Schemas.Project{
          name: sequence(:name, &"name-#{&1}"),
        }
      end
    end
  end
end

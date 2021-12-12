defmodule Fleature.ProjectFactory do
  defmacro __using__(_opts) do
    quote do
      def project_factory do
        %Fleature.Schemas.Project{
          name: sequence(:project_name, &"name-#{&1}"),
          organization: build(:organization)
        }
      end
    end
  end
end

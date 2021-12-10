defmodule Fleature.OrganizationFactory do
  defmacro __using__(_opts) do
    quote do
      def organization_factory do
        %Fleature.Schemas.Organization{
          name: sequence(:name, &"name-#{&1}"),
        }
      end
    end
  end
end

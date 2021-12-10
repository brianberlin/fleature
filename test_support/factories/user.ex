defmodule Fleature.UserFactory do
  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %Fleature.Schemas.User{
          email: sequence(:email, &"email-#{&1}@example.com"),
          hashed_password: sequence(:hashed_password, &"#{&1}")
        }
      end

      def users_organization_factory do
        %Fleature.Schemas.UsersOrganization{
          user: build(:user),
          organization: build(:organization)
        }
      end

      def with_organization(user, opts \\ []) do
        organization = insert(:organization, opts)
        insert(:users_organization, organization: organization, user: user)
        %{user: user, organization: organization}
      end
    end
  end
end

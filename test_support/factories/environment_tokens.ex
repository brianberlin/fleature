defmodule Fleature.EnvironmentTokenFactory do
  defmacro __using__(_opts) do
    quote do
      def environment_token_factory do
        client_id = :crypto.strong_rand_bytes(16)
        %Fleature.Schemas.EnvironmentToken{
          client_id: client_id,
          hashed_client_secret: :crypto.hash(:sha256, client_id),
          environment: build(:environment),
          user: build(:user)
        }
      end
    end
  end
end

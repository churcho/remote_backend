defmodule RemoteBackend.Factories.UsersFactory do
  @moduledoc """
  This module holds data factory for Admin Accounts
  """
  defmacro __using__(_opts) do
    quote do
      alias RemoteBackend.Users.User

      alias RemoteBackend.Support.Randoms

      def random_user_factory do
        %User{
          points: Randoms.random(:points, :integer)
        }
      end
    end
  end
end

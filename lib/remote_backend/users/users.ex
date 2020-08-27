defmodule RemoteBackend.Users do
  @moduledoc """
  Context module for handling operations to `RemoteBackend.Users`
  """

  alias RemoteBackend.Repo
  alias RemoteBackend.Users.User
  alias RemoteBackend.Users.UserChangeset

  @doc """
  Create a user by passing the params:  %{point: point_data}
  """
  @spec create_user(map()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def create_user(%{"points" => points} = params) do
    %User{}
    |> UserChangeset.create_changeset(params)
    |> Repo.insert()
  end
end

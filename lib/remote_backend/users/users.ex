defmodule RemoteBackend.Users do
  @moduledoc """
  Context module for handling operations to `RemoteBackend.Users`
  """
  import Ecto.Query

  alias RemoteBackend.Repo
  alias RemoteBackend.Users.User
  alias RemoteBackend.Users.UserChangeset

  @doc """
  Create a user by passing the params:  %{point: point_data}
  """
  @spec create_user(map()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def create_user(%{"points" => _points} = params) do
    %User{}
    |> UserChangeset.create_changeset(params)
    |> Repo.insert()
  end

  @doc """
  Get a list of all users in the database
  """
  @spec get_users() :: {:ok, [User.t()]} | {:error, Ecto.Changeset.t()}
  def get_users do
    query =
      from u in User,
        select: u

    Repo.all(query)
  end

  @doc """
  Performs an update on the User
  """
  @spec update_user(User.t(), map()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def update_user(%User{} = user, params) do
    user
    |> UserChangeset.create_changeset(params)
    |> Repo.update()
  end
end

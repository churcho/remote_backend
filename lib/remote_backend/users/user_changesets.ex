defmodule RemoteBackend.Users.UserChangeset do
  @moduledoc """
  Changeset for the actions on `RemoteBackend.Users.User`.
  """

  import Ecto.Changeset

  @fields [
    :points
  ]
  @doc """
  Data transformations used when a new user is created
  """
  @spec create_changeset(User.t() | Ecto.Changeset.t(), map()) :: Ecto.Changeset.t()
  def create_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields, empty_values: [])
    |> validate_required(@fields)
    |> validate_number(:points, greater_than_or_equal_to: 0, less_than_or_equal_to: 100)
  end
end

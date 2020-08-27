defmodule RemoteBackend.Users.User do
  @moduledoc """
  Schema for `RemoteBackend.Users.User`.

  """

  use Ecto.Schema

  @typedoc """
  Type for `RemoteBackend.Users.User.points`
  """
  @type points :: 0..100

  @typedoc """
  Struct type for `RemoteBackend.Users.User`.
  """
  @type t() :: %__MODULE__{
          id: RemoteBackend.primary_key() | nil,
          points: points(),
          inserted_at: DateTime.t() | nil,
          updated_at: DateTime.t() | nil
        }

  schema "users" do
    field(:points, :integer, default: 0)
    timestamps()
  end
end

defmodule RemoteBackend do
  @moduledoc """
  RemoteBackend keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  @typedoc """
  Primary key
  """
  @type primary_key() :: pos_integer()

  @spec get_max_number :: integer()
  def get_max_number do
    Application.get_env(:remote_backend, :max_points, 10)
  end

  @spec get_max_user_to_return :: integer()
  def get_max_user_to_return do
    Application.get_env(:remote_backend, :max_user_to_return, 2)
  end
end

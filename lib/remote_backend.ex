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
end

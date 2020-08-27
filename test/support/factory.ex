defmodule RemoteBackend.Factory do
  @moduledoc """
  This module holds ex machina factories that are used to seed the database
  usually used for the test environment
  """
  alias RemoteBackend.Repo

  use ExMachina.Ecto, repo: Repo

  # Used Factories
  use RemoteBackend.Factories.UsersFactory
end

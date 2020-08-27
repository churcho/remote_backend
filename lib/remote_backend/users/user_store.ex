defmodule RemoteBackend.Users.UserStore do
  @moduledoc """
  Genserver to store user data
  """
  use GenServer, restart: :transient
  require Logger

  alias RemoteBackend.Repo
  alias RemoteBackend.Users
  alias RemoteBackend.Users.User

  def start_link(max_number) do
    GenServer.start_link(__MODULE__, max_number)
  end

  def init(max_number) do
    state = %{
      max_number: max_number,
      timestamp: nil
    }

    {:ok, state, {:continue, :update_state}}
  end

  def handle_continue(:update_state, state) do
    {:ok, timestamp} = Timex.format(Timex.now(), "{YYYY}-{0M}-{D} {h24}:{m}:{s}")
    max = RemoteBackend.get_max_number()
    users = Users.get_users()

    new_state = %{
      timestamp: timestamp,
      users: users,
      max_number: Enum.random(0..max)
    }

    {:noreply, new_state}
  end
end

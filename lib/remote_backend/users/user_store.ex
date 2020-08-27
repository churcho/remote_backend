defmodule RemoteBackend.Users.UserStore do
  @moduledoc """
  Genserver to store user data
  """
  use GenServer, restart: :transient
  require Logger

  alias RemoteBackend.Repo
  alias RemoteBackend.Users
  alias RemoteBackend.Users.User

  @name __MODULE__
  @one_minute 60000

  def start_link(max_number) do
    GenServer.start_link(__MODULE__, max_number, name: @name)
  end

  def init(max_number) do
    state = %{
      max_number: max_number,
      timestamp: nil,
      prev_timestamp: nil,
      users: []
    }

    {:ok, state, {:continue, :update_state}}
  end

  def handle_continue(:update_state, state) do
    Process.send_after(self(), :refresh, @one_minute)

    # Load users listing for ease of updates | reference
    users = Users.get_users()

    new_state = %{state | users: users}
    {:noreply, new_state}
  end

  def handle_info(:refresh, state) do
    {:ok, timestamp} = Timex.format(Timex.now(), "{YYYY}-{0M}-{D} {h24}:{m}:{s}")
    max = RemoteBackend.get_max_number()

    updated_users =
      Users.get_users()
      |> Enum.map(fn u ->
        {:ok, user} = Users.update_user(u, %{id: u.id, points: Enum.random(0..max)})
        user
      end)

    new_state = %{
      timestamp: timestamp,
      max_number: Enum.random(0..max),
      prev_timestamp: state.timestamp,
      users: updated_users
    }

    new_state = Map.merge(state, new_state)
    Process.send_after(self(), :refresh, @one_minute)

    {:noreply, new_state}
  end

  @doc """
  GenServer.handle_call/3 callback
  """
  def handle_call(:get, _from, state) do
    {:ok, timestamp} = Timex.format(Timex.now(), "{YYYY}-{0M}-{D} {h24}:{m}:{s}")
    max_return = RemoteBackend.get_max_user_to_return()
    %{max_number: max, users: users} = state

    max_users =
      users
      |> Enum.filter(fn user ->
        user.points > max
      end)
      |> Enum.take(max_return)

    {:reply, %{users: max_users, timestamp: state.prev_timestamp},
     %{state | timestamp: timestamp}}
  end
end

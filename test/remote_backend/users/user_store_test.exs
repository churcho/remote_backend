defmodule RemoteBackend.UserStoreTest do
  @moduledoc """
  Test the `RemoteBackend.Users.UserStore` GenServer
  """

  use RemoteBackend.DataCase, async: true
  alias RemoteBackend.Users
  alias RemoteBackend.Users.UserStore

  describe "UserStore" do
    # We need to have users in the db for the state tests
    setup do
      max = RemoteBackend.get_max_number()

      Enum.map(1..3, fn _x ->
        params = %{"points" => Enum.random(0..max)}
        Users.create_user(params)
      end)

      :ok
    end

    test "handle_continue loads user_ids into state" do
      params = %{max_number: 0, timestamp: nil}

      {:noreply, %{users: users, max_number: _max_number, timestamp: timestamp}} =
        UserStore.handle_continue(:update_state, params)

      assert length(users) > 0
      refute is_nil(timestamp)
    end
  end
end

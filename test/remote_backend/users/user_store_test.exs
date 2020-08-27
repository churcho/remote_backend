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

      users =
        Enum.map(1..3, fn _x ->
          params = %{"points" => Enum.random(0..max)}
          {:ok, user} = Users.create_user(params)
          user
        end)

      {:ok, users: users}
    end

    test "handle_continue loads user_ids into state" do
      params = %{max_number: 0, timestamp: nil, users: []}

      {:noreply, %{users: users, max_number: _max_number, timestamp: timestamp}} =
        UserStore.handle_continue(:update_state, params)

      assert length(users) > 0
      assert is_nil(timestamp)
    end

    test "handle_info :refresh sets prev_timestamp and sets a new one", %{users: users} do
      {:ok, init_timestamp} =
        Timex.format(Timex.shift(Timex.now(), minutes: -1), "{YYYY}-{0M}-{D} {h24}:{m}:{s}")

      params = %{max_number: 0, timestamp: init_timestamp, users: users}

      {:noreply,
       %{
         timestamp: timestamp,
         prev_timestamp: prev_timestamp
       }} = UserStore.handle_info(:refresh, params)

      assert prev_timestamp == init_timestamp
      refute timestamp == init_timestamp
    end

    @tag :current
    @max_number 200
    test "handle_info :refresh sets a new max_number", %{users: users} do
      {:ok, init_timestamp} =
        Timex.format(Timex.shift(Timex.now(), minutes: -1), "{YYYY}-{0M}-{D} {h24}:{m}:{s}")

      params = %{max_number: @max_number, timestamp: init_timestamp, users: users}

      {:noreply,
       %{
         max_number: max_number
       }} = UserStore.handle_info(:refresh, params)

      assert max_number < @max_number
    end

    @tag :current
    @max_number 200
    test "handle_info :refresh updates users points" do
      {:ok, init_timestamp} =
        Timex.format(Timex.shift(Timex.now(), minutes: -1), "{YYYY}-{0M}-{D} {h24}:{m}:{s}")

      params = %{"points" => @max_number}
      {:ok, user} = Users.create_user(params)
      params = %{max_number: 0, timestamp: init_timestamp, users: [user]}

      {:noreply,
       %{
         users: users
       }} = UserStore.handle_info(:refresh, params)

      user = Enum.find(users, fn u -> u.id == user.id end)
      assert user.points < @max_number
    end
  end
end

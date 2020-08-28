defmodule RemoteBackend.UsersTest do
  @moduledoc """
  Test the `RemoteBackend.Users` context
  """

  use RemoteBackend.DataCase, async: true

  alias RemoteBackend.Users
  alias RemoteBackend.Users.User

  describe ".create_user/1" do
    test "given valid string params" do
      params = string_params_for(:random_user)

      {:ok, %User{points: points}} = Users.create_user(params)

      assert points == params["points"]
    end

    test "given invalid string params" do
      assert_raise FunctionClauseError, ~r/^no function clause matching/, fn ->
        Users.create_user(%{})
      end
    end
  end

  describe ".get_users/0" do
    test "can get a list of users" do
      length = 5

      Enum.map(1..length, fn _x ->
        params = string_params_for(:random_user)
        {:ok, _users} = Users.create_user(params)
      end)

      users = Users.get_users()
      assert length(users) == length
    end
  end

  describe ".update_user/2" do
    @update_points 100
    test "updates an existing user" do
      params = string_params_for(:random_user)
      {:ok, user} = Users.create_user(params)

      update_params = %{id: user.id, points: @update_points}
      {:ok, updated_user} = Users.update_user(user, update_params)
      assert updated_user.points == @update_points
      assert updated_user.id == user.id
    end
  end
end

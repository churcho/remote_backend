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
  end
end

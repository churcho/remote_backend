defmodule RemoteBackend.Users.Changesets.UserCreateChangesetTest do
  @moduledoc """
  Test transformations for the `RemoteBackend.Users.Schemas.User` Schema
  """

  use RemoteBackend.DataCase, async: true
  use FlowAssertions.Ecto

  alias RemoteBackend.Users.UserChangeset
  alias RemoteBackend.Users.User

  describe ".create_changeset/1" do
    test "given valid string keyed params" do
      struct = build(:random_user)
      changeset = UserChangeset.create_changeset(struct)

      assert_valid(changeset)
    end

    test "given invalid string keyed params" do
      struct = build(:random_user, %{points: nil})
      changeset = UserChangeset.create_changeset(struct)
      assert_invalid(changeset)
    end

    test "given an initial %User{} and :user params (atom-keyed)" do
      params = params_for(:random_user)
      changeset = UserChangeset.create_changeset(%User{}, params)

      changeset |> assert_changes(points: params[:points])
      assert_valid(changeset)
    end
  end
end

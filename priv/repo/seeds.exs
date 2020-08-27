# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     RemoteBackend.Repo.insert!(%RemoteBackend.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#

alias RemoteBackend.Users

# Seed users in the database
max_points = Application.get_env(:remote_backend, :max_points, 10)
max_users = Application.get_env(:remote_backend, :max_user_seed, 1)

Enum.map(1..max_users, fn _x ->
  Users.create_user(%{"points" => Enum.random(0..max_points)})
end)

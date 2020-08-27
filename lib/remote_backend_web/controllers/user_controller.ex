defmodule RemoteBackendWeb.UserController do
  use RemoteBackendWeb, :controller

  alias RemoteBackend.Users.UserStore

  def index(conn, _params) do
    %{timestamp: timestamp, users: users} = GenServer.call(UserStore, :get)

    users =
      Enum.map(users, fn u ->
        Map.take(u, [:id, :points])
      end)

    conn
    |> put_status(:ok)
    |> render("show.json", %{users: users, timestamp: timestamp})
  end
end

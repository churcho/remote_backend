defmodule RemoteBackendWeb.UserControllerTest do
  use RemoteBackendWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    %{"timestamp" => timestamp, "users" => users} = json_response(conn, 200)
    assert is_nil(timestamp)
    assert Enum.empty?(users)
  end
end

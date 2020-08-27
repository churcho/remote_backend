defmodule RemoteBackendWeb.UserControllerTest do
  use RemoteBackendWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    response = json_response(conn, 200)
    IO.inspect(response)
  end
end

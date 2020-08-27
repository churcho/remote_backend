defmodule RemoteBackendWeb.UserView do
  use RemoteBackendWeb, :view

  def render(_conn, %{users: users, timestamp: timestamp}) do
    %{"users" => users, timestamp: timestamp}
  end
end

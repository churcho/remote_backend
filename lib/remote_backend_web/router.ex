defmodule RemoteBackendWeb.Router do
  use RemoteBackendWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RemoteBackendWeb do
    pipe_through :api
  end
end

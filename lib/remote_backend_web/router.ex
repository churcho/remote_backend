defmodule RemoteBackendWeb.Router do
  use RemoteBackendWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :csrf do
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RemoteBackendWeb do
    pipe_through :api
  end

  scope "/", RemoteBackendWeb do
    pipe_through [:browser, :csrf]

    get "/", UserController, :index
  end
end

defmodule Pumarex.Web.Router do
  use Pumarex.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  # Other scopes may use custom stacks.
  scope "/api", Pumarex.Web do
    pipe_through :api

    resources "/sessions", SessionController, only: [:create]
    resources "/movies", MovieController, only: [:index, :create, :show]
    resources "/rooms", RoomController, only: [:index, :create, :show, :delete]
    resources "/screenings", ScreeningController
  end

  scope "/", Pumarex.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/*path", PageController, :index
  end
end

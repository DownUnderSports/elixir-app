defmodule DownUnderSportsWeb.Router do
  use DownUnderSportsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DownUnderSportsWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show
    resources "/countries", CountryController
    resources "/sports", SportController
    resources "/states", StateController
  end

  # Other scopes may use custom stacks.
  # scope "/api", DownUnderSportsWeb do
  #   pipe_through :api
  # end
end

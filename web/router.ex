defmodule ShareableEx.Router do
  use ShareableEx.Web, :router

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

  scope "/", ShareableEx do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/@:username", UserController, :profile
    get "/@:username/:post_slug_name", PostController, :show
    get "/tag/:tag", PostController, :list_by_tag

    get "/sign_in", UserController, :sign_in

    get "/sign_up", UserController, :new
    post "/sign_up", UserController, :create

  end

  # Other scopes may use custom stacks.
  # scope "/api", ShareableEx do
  #   pipe_through :api
  # end
end

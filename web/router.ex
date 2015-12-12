defmodule MacMe.Router do
  use MacMe.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", MacMe do
    pipe_through :api

    post "/users", UserController, :create
  end
end

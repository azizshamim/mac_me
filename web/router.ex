defmodule MacMe.Router do
  @moduledoc """
  Main router module for Phoenix. Decides mapping of URL requests to the
  controllers that will ultimately process their requests
  """
  use MacMe.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", MacMe.V1, as: :v1 do
    pipe_through :api

    get "/", PresenceController, :index
    get "/devices", DeviceController, :index
    resources "/users", UserController
    post "/registration", RegistrationController, :create
  end
end

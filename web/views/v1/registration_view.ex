defmodule MacMe.V1.RegistrationView do
  @moduledoc """
  Representation of the data structures that make it back to the user for
  Registering owned devices
  """
  use MacMe.Web, :view

  def render("error.json", %{error: error}) do
    %{
      error: error,
    }
  end

  def render("register.json", %{device: device}) do
    %{
      device: device,
     }
  end

end

defmodule MacMe.User do
  @moduledoc """
  This module defines the model for a User, as it is stored
  in our database.
  """

  @default_avatar "https://avatars1.githubusercontent.com/u/532584"
  defstruct irc_username: nil, github_username: nil, avatar_url: @default_avatar
end

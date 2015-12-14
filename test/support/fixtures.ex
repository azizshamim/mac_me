defmodule MacMe.Test.Support.Fixtures do
  @moduledoc """
  Helper functions that create fake data quickly and easily
  for testing.
  """
  def user do
    random_name = Faker.Internet.user_name

    user = %{
      irc_username: random_name,
      github_username: random_name,
      avatar_url: Faker.Internet.image_url,
    }
  end
end

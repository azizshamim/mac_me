defmodule MacMe.Test.Support.Fixtures do
  def user do
    random_name = Faker.Internet.user_name

    user = %{
      irc_username: random_name,
      github_username: random_name,
      avatar_url: Faker.Internet.image_url,
    }
  end
end

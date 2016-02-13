defmodule MacMe.UserTest do
  use ExUnit.Case

  @valid_attrs %{
    irc_username: Faker.Internet.user_name,
    github_username: Faker.Internet.user_name,
    avatar_url: Faker.Internet.image_url,
  }

  # test "valid attributes should be accepted" do
  #   changeset = User.changeset(%User{}, @valid_attrs)
  #   assert changeset.valid?
  # end

  # test "refuse invalid avatar_url" do
  #   data = %{irc_username: Faker.Internet.user_name,
  #            avatar_url: 'notaurl'}
  #   changeset = User.changeset(%User{}, data)
  #   refute changeset.valid?
  # end
end

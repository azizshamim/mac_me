defmodule MacMe.UserTest do
  use MacMe.ModelCase

  alias MacMe.User

  test "valid attributes should be accepted" do
    data = %{irc_username: Faker.Internet.user_name,
             avatar_url: nil,
             github_username: nil
            }
    changeset = User.changeset(%User{}, data)
    assert changeset.valid?
  end

  test "a valid avatar_url should be accepted" do
    data = %{irc_username: Faker.Internet.user_name,
             avatar_url: Faker.Internet.image_url}
    changeset = User.changeset(%User{}, data)
    assert changeset.valid?
  end

  test "refuse invalid avatar_url" do
    data = %{irc_username: Faker.Internet.user_name,
             avatar_url: 'notaurl'}
    changeset = User.changeset(%User{}, data)
    refute changeset.valid?
  end
end

defmodule MacMe.UserTest do
  use MacMe.ModelCase

  alias MacMe.User

  @valid_attrs %{
    irc_username: Faker.Internet.user_name,
    github_username: Faker.Internet.user_name,
    avatar_url: Faker.Internet.image_url,
  }

  test "valid attributes should be accepted" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "refuse invalid avatar_url" do
    data = %{irc_username: Faker.Internet.user_name,
             avatar_url: 'notaurl'}
    changeset = User.changeset(%User{}, data)
    refute changeset.valid?
  end

  test "refute a duplicate irc_username" do
    %User{}
    |> User.changeset(@valid_attrs)
    |> Repo.insert!

    duplicate_user = %User{}
    |> User.changeset(@valid_attrs)

    assert {:error, changeset} = Repo.insert(duplicate_user)
    assert changeset.errors[:irc_username] == "has already been taken"
  end

  test "refute a duplicate github_username" do
    user = @valid_attrs
    duplicate_user = user
    |> Dict.put(:irc_username, Faker.Internet.user_name)

    %User{}
    |> User.changeset(user)
    |> Repo.insert!

    response = %User{}
    |> User.changeset(duplicate_user)

    assert {:error, changeset} = Repo.insert(response)
    assert changeset.errors[:github_username] == "has already been taken"
  end
end

defmodule MacMe.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :irc_username, :string
      add :github_username, :string
      add :avatar_url, :string

      timestamps
    end

  end
end

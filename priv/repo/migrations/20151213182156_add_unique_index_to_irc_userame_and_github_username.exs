defmodule MacMe.Repo.Migrations.AddUniqueIndexToIrcUserameAndGithubUsername do
  use Ecto.Migration

  def change do
    create unique_index(:users, [:irc_username])
    create unique_index(:users, [:github_username])
  end
end

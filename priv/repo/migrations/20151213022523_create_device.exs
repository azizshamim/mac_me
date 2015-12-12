defmodule MacMe.Repo.Migrations.CreateDevice do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add :mac_address, :string
      add :user_id, references(:users)

      timestamps
    end
    create index(:devices, [:user_id])

  end
end

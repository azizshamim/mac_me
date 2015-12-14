defmodule MacMe.Repo.Migrations.AddNameToDevice do
  use Ecto.Migration

  def change do
    alter table(:devices) do
      add :name, :string
    end
  end
end

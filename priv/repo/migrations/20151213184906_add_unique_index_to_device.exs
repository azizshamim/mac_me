defmodule MacMe.Repo.Migrations.AddUniqueIndexToDevice do
  use Ecto.Migration

  def change do
    create unique_index(:devices, [:mac_address])
  end
end

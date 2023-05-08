defmodule Discordia.Repo.Migrations.CreateServers do
  use Ecto.Migration

  def change do
    create table(:servers) do
      add :name, :string
      add :description, :text

      timestamps()
    end
  end
end

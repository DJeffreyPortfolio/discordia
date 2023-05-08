defmodule Discordia.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :context, :text
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all)
      add :server_id, references(:servers, on_delete: :delete_all)

      timestamps()
    end

    create index(:messages, [:user_id])
    create index(:messages, [:server_id])
  end
end

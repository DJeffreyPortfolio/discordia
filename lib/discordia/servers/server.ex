defmodule Discordia.Servers.Server do
  use Ecto.Schema
  import Ecto.Changeset

  alias Discordia.Servers.Message

  schema "servers" do
    field :description, :string
    field :name, :string
    has_many :messages, Message

    timestamps()
  end

  @doc false
  def changeset(server, attrs) do
    server
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end

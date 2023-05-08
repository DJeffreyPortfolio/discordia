defmodule Discordia.Servers.Message do
  use Ecto.Schema
  import Ecto.Changeset

  alias Discordia.Servers.Server
  alias Discordia.Accounts.User

  schema "messages" do
    field :context, :string
    belongs_to :user, User, type: :binary_id
    belongs_to :server, Server

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:context])
    |> validate_required([:context])
  end
end

defmodule Discordia.Repo do
  use Ecto.Repo,
    otp_app: :discordia,
    adapter: Ecto.Adapters.Postgres
end

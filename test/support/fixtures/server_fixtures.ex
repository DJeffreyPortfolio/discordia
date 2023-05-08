defmodule Discordia.ServerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Discordia.Server` context.
  """

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        context: "some context"
      })
      |> Discordia.Server.create_message()

    message
  end
end

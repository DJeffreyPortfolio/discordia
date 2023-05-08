defmodule Discordia.ServerTest do
  use Discordia.DataCase

  alias Discordia.Server

  describe "messages" do
    alias Discordia.Server.Message

    import Discordia.ServerFixtures

    @invalid_attrs %{context: nil}

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Server.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Server.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      valid_attrs = %{context: "some context"}

      assert {:ok, %Message{} = message} = Server.create_message(valid_attrs)
      assert message.context == "some context"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Server.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      update_attrs = %{context: "some updated context"}

      assert {:ok, %Message{} = message} = Server.update_message(message, update_attrs)
      assert message.context == "some updated context"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Server.update_message(message, @invalid_attrs)
      assert message == Server.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Server.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Server.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Server.change_message(message)
    end
  end
end

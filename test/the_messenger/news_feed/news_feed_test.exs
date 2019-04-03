defmodule TheMessenger.NewsFeedTest do
  use TheMessenger.DataCase

  alias TheMessenger.NewsFeed

  describe "messages" do
    alias TheMessenger.NewsFeed.Message

    @valid_attrs %{body: "some body", from: "some from", to: "some to"}
    @update_attrs %{body: "some updated body", from: "some updated from", to: "some updated to"}
    @invalid_attrs %{body: nil, from: nil, to: nil}

    def message_fixture(attrs \\ %{}) do
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> NewsFeed.create_message()

      message
    end

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert NewsFeed.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert NewsFeed.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      assert {:ok, %Message{} = message} = NewsFeed.create_message(@valid_attrs)
      assert message.body == "some body"
      assert message.from == "some from"
      assert message.to == "some to"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = NewsFeed.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      assert {:ok, %Message{} = message} = NewsFeed.update_message(message, @update_attrs)
      assert message.body == "some updated body"
      assert message.from == "some updated from"
      assert message.to == "some updated to"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = NewsFeed.update_message(message, @invalid_attrs)
      assert message == NewsFeed.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = NewsFeed.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> NewsFeed.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = NewsFeed.change_message(message)
    end
  end
end

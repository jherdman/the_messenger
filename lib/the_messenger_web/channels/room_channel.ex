defmodule TheMessengerWeb.RoomChannel do
  use Phoenix.Channel

  alias TheMessenger.NewsFeed

  def join("room:lobby", %{"nickname" => nickname}, socket) do
    socket = assign(socket, :nickname, nickname)

    {:ok, socket}
  end

  def handle_in("new:msg", %{"data" => %{"attributes" => attributes}}, socket) do
    %{
      assigns: %{
        nickname: nickname,
      }
    } = socket

    attributes = attributes
                 |> normalize_attributes()
                 |> Map.put_new(:from, nickname)

    {:ok, message} = NewsFeed.create_message(attributes)

    serialized_message = serialize_message(message)

    broadcast!(socket, "new:msg", serialized_message)

    {:noreply, socket}
  end

  defp serialize_message(message) do
    %{
      "data" => %{
        "id" => message.id,
        "type" => "message",
        "attributes" => %{
          "from" => message.from,
          "body" => message.body,
          "sentAt" => message.sent_at,
        }
      }
    }
  end

  def normalize_attributes(%{"sentAt" => sent_at, "message" => body}) do
    %{body: body, sent_at: sent_at}
  end
end

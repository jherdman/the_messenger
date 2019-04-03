defmodule TheMessenger.NewsFeed.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :body, :string
    field :from, :string
    field :sent_at, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:from, :sent_at, :body])
    |> validate_required([:from, :sent_at, :body])
  end
end

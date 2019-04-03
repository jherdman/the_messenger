defmodule TheMessenger.Repo.Migrations.AddSentAtToMessages do
  use Ecto.Migration

  def change do
    alter table(:messages) do
      add :sent_at, :naive_datetime
    end
  end
end

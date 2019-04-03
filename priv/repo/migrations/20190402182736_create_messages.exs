defmodule TheMessenger.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :from, :string
      add :to, :string
      add :body, :string

      timestamps()
    end

  end
end

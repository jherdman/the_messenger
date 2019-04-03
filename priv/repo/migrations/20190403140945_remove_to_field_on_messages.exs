defmodule TheMessenger.Repo.Migrations.RemoveToFieldOnMessages do
  use Ecto.Migration

  def change do
    alter table(:messages) do
      remove :to, :string
    end
  end
end

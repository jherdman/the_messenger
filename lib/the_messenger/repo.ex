defmodule TheMessenger.Repo do
  use Ecto.Repo,
    otp_app: :the_messenger,
    adapter: Ecto.Adapters.Postgres
end

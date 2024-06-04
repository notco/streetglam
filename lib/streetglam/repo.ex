defmodule Streetglam.Repo do
  use Ecto.Repo,
    otp_app: :streetglam,
    adapter: Ecto.Adapters.Postgres
end

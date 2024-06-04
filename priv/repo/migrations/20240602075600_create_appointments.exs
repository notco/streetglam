defmodule Streetglam.Repo.Migrations.CreateAppointments do
  use Ecto.Migration

  def change do
    create table(:appointments) do
      add :name, :string
      add :schedule, :utc_datetime
      add :contact, :string

      timestamps(type: :utc_datetime)
    end
  end
end

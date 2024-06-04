defmodule Streetglam.Repo.Migrations.CreateAppointments do
  use Ecto.Migration

  def change do
    create table(:appointments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :schedule, :utc_datetime
      add :contact, :string

      timestamps(type: :utc_datetime)
    end
  end
end

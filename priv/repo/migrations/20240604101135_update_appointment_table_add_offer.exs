defmodule Streetglam.Repo.Migrations.UpdateAppointmentTableAddOffer do
  use Ecto.Migration

  def change do
    alter table(:appointments) do
      add :offer_id, references(:offers, type: :binary_id, on_delete: :delete_all)
    end
  end
end

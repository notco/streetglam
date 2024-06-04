defmodule Streetglam.Repo.Migrations.CreateOffers do
  use Ecto.Migration

  def change do
    create table(:offers) do
      add :name, :string
      add :description, :string

      timestamps(type: :utc_datetime)
    end
  end
end

defmodule Streetglam.Services.Appointment do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "appointments" do
    field :contact, :string
    field :name, :string
    field :schedule, :utc_datetime

    belongs_to :offer, Streetglam.Services.Offer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(appointment, attrs) do
    appointment
    |> cast(attrs, [:name, :schedule, :contact, :offer_id])
    |> validate_required([:name, :schedule, :contact, :offer_id])
  end
end

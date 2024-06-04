defmodule Streetglam.Services.Appointment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "appointments" do
    field :contact, :string
    field :name, :string
    field :schedule, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(appointment, attrs) do
    appointment
    |> cast(attrs, [:name, :schedule, :contact])
    |> validate_required([:name, :schedule, :contact])
  end
end

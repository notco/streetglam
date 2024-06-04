defmodule Streetglam.Services.Offer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "offers" do
    field :description, :string
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(offer, attrs) do
    offer
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end

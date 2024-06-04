defmodule Streetglam.ServicesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Streetglam.Services` context.
  """

  @doc """
  Generate a appointment.
  """
  def appointment_fixture(attrs \\ %{}) do
    {:ok, appointment} =
      attrs
      |> Enum.into(%{
        contact: "some contact",
        name: "some name",
        schedule: ~U[2024-06-01 07:56:00Z]
      })
      |> Streetglam.Services.create_appointment()

    appointment
  end

  @doc """
  Generate a offer.
  """
  def offer_fixture(attrs \\ %{}) do
    {:ok, offer} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> Streetglam.Services.create_offer()

    offer
  end
end

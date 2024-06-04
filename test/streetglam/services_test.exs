defmodule Streetglam.ServicesTest do
  use Streetglam.DataCase

  alias Streetglam.Services

  describe "appointments" do
    alias Streetglam.Services.Appointment

    import Streetglam.ServicesFixtures

    @invalid_attrs %{contact: nil, name: nil, schedule: nil}

    test "list_appointments/0 returns all appointments" do
      appointment = appointment_fixture()
      assert Services.list_appointments() == [appointment]
    end

    test "get_appointment!/1 returns the appointment with given id" do
      appointment = appointment_fixture()
      assert Services.get_appointment!(appointment.id) == appointment
    end

    test "create_appointment/1 with valid data creates a appointment" do
      valid_attrs = %{
        contact: "some contact",
        name: "some name",
        schedule: ~U[2024-06-01 07:56:00Z]
      }

      assert {:ok, %Appointment{} = appointment} = Services.create_appointment(valid_attrs)
      assert appointment.contact == "some contact"
      assert appointment.name == "some name"
      assert appointment.schedule == ~U[2024-06-01 07:56:00Z]
    end

    test "create_appointment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Services.create_appointment(@invalid_attrs)
    end

    test "update_appointment/2 with valid data updates the appointment" do
      appointment = appointment_fixture()

      update_attrs = %{
        contact: "some updated contact",
        name: "some updated name",
        schedule: ~U[2024-06-02 07:56:00Z]
      }

      assert {:ok, %Appointment{} = appointment} =
               Services.update_appointment(appointment, update_attrs)

      assert appointment.contact == "some updated contact"
      assert appointment.name == "some updated name"
      assert appointment.schedule == ~U[2024-06-02 07:56:00Z]
    end

    test "update_appointment/2 with invalid data returns error changeset" do
      appointment = appointment_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Services.update_appointment(appointment, @invalid_attrs)

      assert appointment == Services.get_appointment!(appointment.id)
    end

    test "delete_appointment/1 deletes the appointment" do
      appointment = appointment_fixture()
      assert {:ok, %Appointment{}} = Services.delete_appointment(appointment)
      assert_raise Ecto.NoResultsError, fn -> Services.get_appointment!(appointment.id) end
    end

    test "change_appointment/1 returns a appointment changeset" do
      appointment = appointment_fixture()
      assert %Ecto.Changeset{} = Services.change_appointment(appointment)
    end
  end

  describe "offers" do
    alias Streetglam.Services.Offer

    import Streetglam.ServicesFixtures

    @invalid_attrs %{description: nil, name: nil}

    test "list_offers/0 returns all offers" do
      offer = offer_fixture()
      assert Services.list_offers() == [offer]
    end

    test "get_offer!/1 returns the offer with given id" do
      offer = offer_fixture()
      assert Services.get_offer!(offer.id) == offer
    end

    test "create_offer/1 with valid data creates a offer" do
      valid_attrs = %{description: "some description", name: "some name"}

      assert {:ok, %Offer{} = offer} = Services.create_offer(valid_attrs)
      assert offer.description == "some description"
      assert offer.name == "some name"
    end

    test "create_offer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Services.create_offer(@invalid_attrs)
    end

    test "update_offer/2 with valid data updates the offer" do
      offer = offer_fixture()
      update_attrs = %{description: "some updated description", name: "some updated name"}

      assert {:ok, %Offer{} = offer} = Services.update_offer(offer, update_attrs)
      assert offer.description == "some updated description"
      assert offer.name == "some updated name"
    end

    test "update_offer/2 with invalid data returns error changeset" do
      offer = offer_fixture()
      assert {:error, %Ecto.Changeset{}} = Services.update_offer(offer, @invalid_attrs)
      assert offer == Services.get_offer!(offer.id)
    end

    test "delete_offer/1 deletes the offer" do
      offer = offer_fixture()
      assert {:ok, %Offer{}} = Services.delete_offer(offer)
      assert_raise Ecto.NoResultsError, fn -> Services.get_offer!(offer.id) end
    end

    test "change_offer/1 returns a offer changeset" do
      offer = offer_fixture()
      assert %Ecto.Changeset{} = Services.change_offer(offer)
    end
  end
end

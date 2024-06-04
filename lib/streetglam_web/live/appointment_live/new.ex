defmodule StreetglamWeb.AppointmentLive.New do
  use StreetglamWeb, :live_view

  alias Streetglam.Services
  alias Streetglam.Services.Appointment

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       appointment: %Appointment{},
       page_title: "New Appointment",
       offers: Services.list_offers()
     )}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    appointment = Services.get_appointment!(id)
    {:ok, _} = Services.delete_appointment(appointment)

    {:noreply, stream_delete(socket, :appointments, appointment)}
  end
end

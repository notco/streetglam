defmodule StreetglamWeb.AppointmentLive.FormComponent do
  use StreetglamWeb, :live_component

  alias Streetglam.Services

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle></:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="appointment-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" required />
        <.input field={@form[:schedule]} type="datetime-local" label="Schedule" required />
        <.input field={@form[:contact]} type="text" label="Contact" required />
        <.offer_input field={@form[:offer_id]} offers={@offers} />
        <:actions>
          <.button phx-disable-with="Saving...">Save Appointment</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{appointment: appointment} = assigns, socket) do
    changeset = Services.change_appointment(appointment)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  def offer_input(assigns) do
    ~H"""
    <.input
      field={@field}
      type="select"
      label="Service"
      options={Enum.map(@offers, fn o -> {o.name, o.id} end)}
      required
    />
    """
  end

  @impl true
  def handle_event("validate", %{"appointment" => appointment_params}, socket) do
    changeset =
      socket.assigns.appointment
      |> Services.change_appointment(appointment_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"appointment" => appointment_params}, socket) do
    save_appointment(socket, socket.assigns.action, appointment_params)
  end

  defp save_appointment(socket, :edit, appointment_params) do
    case Services.update_appointment(socket.assigns.appointment, appointment_params) do
      {:ok, appointment} ->
        notify_parent({:saved, appointment})

        {:noreply,
         socket
         |> put_flash(:info, "Appointment updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_appointment(socket, :new, appointment_params) do
    case Services.create_appointment(appointment_params) do
      {:ok, appointment} ->
        notify_parent({:saved, appointment})

        {:noreply,
         socket
         |> put_flash(:info, "Appointment created successfully")
         |> redirect(to: ~p"/")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

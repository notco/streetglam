defmodule StreetglamWeb.OfferLive.FormComponent do
  use StreetglamWeb, :live_component

  alias Streetglam.Services

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage offer records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="offer-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Offer</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{offer: offer} = assigns, socket) do
    changeset = Services.change_offer(offer)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"offer" => offer_params}, socket) do
    changeset =
      socket.assigns.offer
      |> Services.change_offer(offer_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"offer" => offer_params}, socket) do
    save_offer(socket, socket.assigns.action, offer_params)
  end

  defp save_offer(socket, :edit, offer_params) do
    case Services.update_offer(socket.assigns.offer, offer_params) do
      {:ok, offer} ->
        notify_parent({:saved, offer})

        {:noreply,
         socket
         |> put_flash(:info, "Offer updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_offer(socket, :new, offer_params) do
    case Services.create_offer(offer_params) do
      {:ok, offer} ->
        notify_parent({:saved, offer})

        {:noreply,
         socket
         |> put_flash(:info, "Offer created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

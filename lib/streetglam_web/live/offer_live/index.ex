defmodule StreetglamWeb.OfferLive.Index do
  use StreetglamWeb, :live_view

  alias Streetglam.Services
  alias Streetglam.Services.Offer

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :offers, Services.list_offers())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Offer")
    |> assign(:offer, Services.get_offer!(id))
  end

  defp apply_action(socket, :new, _params) do
    IO.inspect(socket.assigns.streams.offers)

    socket
    |> assign(:page_title, "New Offer")
    |> assign(:offer, %Offer{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Offers")
    |> assign(:offer, nil)
  end

  @impl true
  def handle_info({StreetglamWeb.OfferLive.FormComponent, {:saved, offer}}, socket) do
    {:noreply, stream_insert(socket, :offers, offer)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    offer = Services.get_offer!(id)
    {:ok, _} = Services.delete_offer(offer)

    {:noreply, stream_delete(socket, :offers, offer)}
  end
end

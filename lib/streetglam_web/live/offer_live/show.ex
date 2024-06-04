defmodule StreetglamWeb.OfferLive.Show do
  use StreetglamWeb, :live_view

  alias Streetglam.Services

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:offer, Services.get_offer!(id))}
  end

  defp page_title(:show), do: "Show Offer"
  defp page_title(:edit), do: "Edit Offer"
end

defmodule StreetglamWeb.OfferLiveTest do
  use StreetglamWeb.ConnCase

  import Phoenix.LiveViewTest
  import Streetglam.ServicesFixtures

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  defp create_offer(_) do
    offer = offer_fixture()
    %{offer: offer}
  end

  describe "Index" do
    setup [:create_offer]

    test "lists all offers", %{conn: conn, offer: offer} do
      {:ok, _index_live, html} = live(conn, ~p"/offers")

      assert html =~ "Listing Offers"
      assert html =~ offer.description
    end

    test "saves new offer", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/offers")

      assert index_live |> element("a", "New Offer") |> render_click() =~
               "New Offer"

      assert_patch(index_live, ~p"/offers/new")

      assert index_live
             |> form("#offer-form", offer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#offer-form", offer: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/offers")

      html = render(index_live)
      assert html =~ "Offer created successfully"
      assert html =~ "some description"
    end

    test "updates offer in listing", %{conn: conn, offer: offer} do
      {:ok, index_live, _html} = live(conn, ~p"/offers")

      assert index_live |> element("#offers-#{offer.id} a", "Edit") |> render_click() =~
               "Edit Offer"

      assert_patch(index_live, ~p"/offers/#{offer}/edit")

      assert index_live
             |> form("#offer-form", offer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#offer-form", offer: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/offers")

      html = render(index_live)
      assert html =~ "Offer updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes offer in listing", %{conn: conn, offer: offer} do
      {:ok, index_live, _html} = live(conn, ~p"/offers")

      assert index_live |> element("#offers-#{offer.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#offers-#{offer.id}")
    end
  end

  describe "Show" do
    setup [:create_offer]

    test "displays offer", %{conn: conn, offer: offer} do
      {:ok, _show_live, html} = live(conn, ~p"/offers/#{offer}")

      assert html =~ "Show Offer"
      assert html =~ offer.description
    end

    test "updates offer within modal", %{conn: conn, offer: offer} do
      {:ok, show_live, _html} = live(conn, ~p"/offers/#{offer}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Offer"

      assert_patch(show_live, ~p"/offers/#{offer}/show/edit")

      assert show_live
             |> form("#offer-form", offer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#offer-form", offer: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/offers/#{offer}")

      html = render(show_live)
      assert html =~ "Offer updated successfully"
      assert html =~ "some updated description"
    end
  end
end

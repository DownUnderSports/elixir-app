defmodule DownUnderSportsWeb.SportControllerTest do
  use DownUnderSportsWeb.ConnCase

  alias DownUnderSports.Metas

  @create_attrs %{abbr: "AA", abbr_gender: "AAA", full: "some full", full_gender: "some full_gender", is_numbered: true, is_meta: false}
  @update_attrs %{abbr: "BA", abbr_gender: "BAB", full: "some updated full", full_gender: "some updated full_gender", is_numbered: false, is_meta: true}
  @invalid_attrs %{abbr: nil, abbr_gender: nil, full: nil, full_gender: nil, is_numbered: nil, is_meta: nil}

  def fixture(:sport) do
    {:ok, sport} = Metas.create_sport(@create_attrs)
    sport
  end

  describe "index" do
    test "lists all sports", %{conn: conn} do
      conn = get(conn, Routes.sport_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Sports"
    end
  end

  describe "new sport" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.sport_path(conn, :new))
      assert html_response(conn, 200) =~ "New Sport"
    end
  end

  describe "create sport" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.sport_path(conn, :create), sport: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.sport_path(conn, :show, id)

      conn = get(conn, Routes.sport_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Sport"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.sport_path(conn, :create), sport: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Sport"
    end
  end

  describe "edit sport" do
    setup [:create_sport]

    test "renders form for editing chosen sport", %{conn: conn, sport: sport} do
      conn = get(conn, Routes.sport_path(conn, :edit, sport))
      assert html_response(conn, 200) =~ "Edit Sport"
    end
  end

  describe "update sport" do
    setup [:create_sport]

    test "redirects when data is valid", %{conn: conn, sport: sport} do
      conn = put(conn, Routes.sport_path(conn, :update, sport), sport: @update_attrs)
      assert redirected_to(conn) == Routes.sport_path(conn, :show, sport)

      conn = get(conn, Routes.sport_path(conn, :show, sport))
      assert html_response(conn, 200) =~ "BA"
      assert html_response(conn, 200) =~ "Some Updated Full"
      assert html_response(conn, 200) =~ "Some Updated Full_gender"
    end

    test "renders errors when data is invalid", %{conn: conn, sport: sport} do
      conn = put(conn, Routes.sport_path(conn, :update, sport), sport: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Sport"
    end
  end

  describe "delete sport" do
    setup [:create_sport]

    test "deletes chosen sport", %{conn: conn, sport: sport} do
      conn = delete(conn, Routes.sport_path(conn, :delete, sport))
      assert redirected_to(conn) == Routes.sport_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.sport_path(conn, :show, sport))
      end
    end
  end

  defp create_sport(_) do
    sport = fixture(:sport)
    {:ok, sport: sport}
  end
end

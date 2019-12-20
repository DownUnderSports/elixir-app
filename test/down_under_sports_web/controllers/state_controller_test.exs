defmodule DownUnderSportsWeb.StateControllerTest do
  use DownUnderSportsWeb.ConnCase, async: true

  alias DownUnderSports.Location

  @create_attrs %{abbr: "KA", country_code: "USA", full: "Kastate", observes_dst: true, tz_offset: -7}
  @update_attrs %{abbr: "vb", country_code: "abd", full: "ok state", observes_dst: false, tz_offset: 0}
  @invalid_attrs %{abbr: nil, country_code: nil, full: nil, observes_dst: nil, tz_offset: nil}

  def fixture(:state) do
    {:ok, state} = Location.create_state(@create_attrs)
    state
  end

  describe "index" do
    test "lists all states", %{conn: conn} do
      conn = get(conn, Routes.state_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing States"
    end
  end

  describe "new state" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.state_path(conn, :new))
      assert html_response(conn, 200) =~ "New State"
    end
  end

  describe "create state" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.state_path(conn, :create), state: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.state_path(conn, :show, id)

      conn = get(conn, Routes.state_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show State"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.state_path(conn, :create), state: @invalid_attrs)
      assert html_response(conn, 200) =~ "New State"
    end
  end

  describe "edit state" do
    setup [:create_state]

    test "renders form for editing chosen state", %{conn: conn, state: state} do
      conn = get(conn, Routes.state_path(conn, :edit, state))
      assert html_response(conn, 200) =~ "Edit State"
    end
  end

  describe "update state" do
    setup [:create_state]

    test "redirects when data is valid", %{conn: conn, state: state} do
      conn = put(conn, Routes.state_path(conn, :update, state), state: @update_attrs)
      assert redirected_to(conn) == Routes.state_path(conn, :show, state)

      conn = get(conn, Routes.state_path(conn, :show, state))
      assert html_response(conn, 200) =~ "Ok State"
      assert html_response(conn, 200) =~ "ABD"
      assert html_response(conn, 200) =~ "VB"
    end

    test "renders errors when data is invalid", %{conn: conn, state: state} do
      conn = put(conn, Routes.state_path(conn, :update, state), state: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit State"
    end
  end

  describe "delete state" do
    setup [:create_state]

    test "deletes chosen state", %{conn: conn, state: state} do
      conn = delete(conn, Routes.state_path(conn, :delete, state))
      assert redirected_to(conn) == Routes.state_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.state_path(conn, :show, state))
      end
    end
  end

  defp create_state(_) do
    state = fixture(:state)
    {:ok, state: state}
  end
end

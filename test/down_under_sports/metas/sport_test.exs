defmodule DownUnderSports.Metas.SportTest do
  use DownUnderSports.DataCase

  alias DownUnderSports.Metas

  describe "sports" do
    alias DownUnderSports.Metas.Sport

    @valid_attrs %{abbr: "AA", abbr_gender: "AAA", full: "some full", full_gender: "some full_gender", is_numbered: true, is_meta: false}
    @update_attrs %{abbr: "BA", abbr_gender: "BA", full: "some updated full", full_gender: "some updated full_gender", is_numbered: false, is_meta: true}
    @invalid_attrs %{abbr: nil, abbr_gender: nil, full: nil, full_gender: nil, is_numbered: nil, is_meta: nil}

    def sport_fixture(attrs \\ %{}) do
      {:ok, sport} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Metas.create_sport()

      sport
    end

    test "list_sports/0 returns all sports" do
      sport = sport_fixture()
      assert Metas.list_sports() == [sport]
    end

    test "get_sport!/1 returns the sport with given id" do
      sport = sport_fixture()
      assert Metas.get_sport!(sport.id) == sport
    end

    test "create_sport/1 with valid data creates a sport" do
      assert {:ok, %Sport{} = sport} = Metas.create_sport(@valid_attrs)
      assert sport.abbr == "AA"
      assert sport.abbr_gender == "AAA"
      assert sport.full == "Some Full"
      assert sport.full_gender == "Some Full_gender"
      assert sport.is_numbered == true
      assert sport.is_meta == false
    end

    test "create_sport/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Metas.create_sport(@invalid_attrs)
    end

    test "update_sport/2 with valid data updates the sport" do
      sport = sport_fixture()
      assert {:ok, %Sport{} = sport} = Metas.update_sport(sport, @update_attrs)
      assert sport.abbr == "BA"
      assert sport.abbr_gender == "BA"
      assert sport.full == "Some Updated Full"
      assert sport.full_gender == "Some Updated Full_gender"
      assert sport.is_numbered == false
      assert sport.is_meta == true
    end

    test "update_sport/2 with invalid data returns error changeset" do
      sport = sport_fixture()
      assert {:error, %Ecto.Changeset{}} = Metas.update_sport(sport, @invalid_attrs)
      assert sport == Metas.get_sport!(sport.id)
    end

    test "delete_sport/1 deletes the sport" do
      sport = sport_fixture()
      assert {:ok, %Sport{}} = Metas.delete_sport(sport)
      assert_raise Ecto.NoResultsError, fn -> Metas.get_sport!(sport.id) end
    end

    test "change_sport/1 returns a sport changeset" do
      sport = sport_fixture()
      assert %Ecto.Changeset{} = Metas.change_sport(sport)
    end
  end
end

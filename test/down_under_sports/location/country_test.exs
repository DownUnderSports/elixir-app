defmodule DownUnderSports.Location.CountryTest do
  use DownUnderSports.DataCase, async: true

  alias DownUnderSports.Location

  describe "countries" do
    alias DownUnderSports.Location.Country

    @valid_attrs %{address_format: "some address_format", code: "ABD", full: "Some Country", state_abbr_length: 1}
    @update_attrs %{address_format: "some updated address_format", code: "some updated code", full: "some updated country", state_abbr_length: 2}
    @invalid_attrs %{address_format: nil, code: nil, full: nil, state_abbr_length: nil}

    def country_fixture(attrs \\ %{}) do
      {:ok, country} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Location.create_country()

      country
    end

    test "list_countries/0 returns all countries" do
      country = country_fixture()
      assert Location.list_countries() == [country]
    end

    test "get_country!/1 returns the country with given id" do
      country = country_fixture()
      assert Location.get_country!(country.id) == country
    end

    test "create_country/1 with valid data creates a country" do
      assert {:ok, %Country{} = country} = Location.create_country(@valid_attrs)
      assert country.address_format == "some address_format"
      assert country.code == "ABD"
      assert country.full == "Some Country"
      assert country.state_abbr_length == 1
    end

    test "create_country/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Location.create_country(@invalid_attrs)
    end

    test "update_country/2 with valid data updates the country" do
      country = country_fixture()
      assert {:ok, %Country{} = country} = Location.update_country(country, @update_attrs)
      assert country.address_format == "some updated address_format"
      assert country.code == "SOM"
      assert country.full == "Some Updated Country"
      assert country.state_abbr_length == 2
    end

    test "update_country/2 with invalid data returns error changeset" do
      country = country_fixture()
      assert {:error, %Ecto.Changeset{}} = Location.update_country(country, @invalid_attrs)
      assert country == Location.get_country!(country.id)
    end

    test "delete_country/1 deletes the country" do
      country = country_fixture()
      assert {:ok, %Country{}} = Location.delete_country(country)
      assert_raise Ecto.NoResultsError, fn -> Location.get_country!(country.id) end
    end

    test "change_country/1 returns a country changeset" do
      country = country_fixture()
      assert %Ecto.Changeset{} = Location.change_country(country)
    end
  end
end

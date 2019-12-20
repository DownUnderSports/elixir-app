defmodule DownUnderSports.Location.AddressTest do
  use DownUnderSports.DataCase, async: true

  alias DownUnderSports.Location

  describe "addresses" do
    use DownUnderSports.Fixtures, [:state]

    alias DownUnderSports.Location.Address

    @valid_attrs %{care_of: "some care_of", city: "some city", company: "some company", lines: [], status: "pending", zip: "some zip", state_id: 1}
    @update_attrs %{care_of: "some updated care_of", city: "some updated city", company: "some updated company", lines: [], status: "confirmed", zip: "some updated zip"}
    @invalid_attrs %{care_of: nil, city: nil, company: nil, lines: nil, status: nil, zip: nil, state_id: nil}

    def address_fixture(attrs \\ %{}) do
      {:ok, address} =
        attrs
        |> address_attrs()
        |> Location.create_address()

      address |> Repo.preload(:state)
    end

    def address_attrs(attrs \\ %{}) do
      state_id = get_or_create_state().id
      %{state_id: state_id}
      |> Enum.into(attrs)
      |> Enum.into(@valid_attrs)
    end

    test "belongs_to Location.State" do
      association =
        %Ecto.Association.BelongsTo{
          field: :state, owner: Address, cardinality: :one,
          related: Location.State, owner_key: :state_id, related_key: :id, queryable: Location.State,
          on_replace: :raise, defaults: []
        }

      assert Address.__schema__(:association, :state) == association
    end

    test "list_addresses/0 returns all addresses" do
      address = address_fixture()
      assert Location.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert Location.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      assert {:ok, %Address{} = address} = Location.create_address(address_attrs(@valid_attrs))
      assert address.care_of == "some care_of"
      assert address.city == "some city"
      assert address.company == "some company"
      assert address.lines == []
      assert address.status == :pending
      assert address.zip == "some zip"
    end

    test "create_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Location.create_address(address_attrs(@invalid_attrs))
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()
      assert {:ok, %Address{} = address} = Location.update_address(address, address_attrs(@update_attrs))
      assert address.care_of == "some updated care_of"
      assert address.city == "some updated city"
      assert address.company == "some updated company"
      assert address.lines == []
      assert address.status == :confirmed
      assert address.zip == "some updated zip"
    end

    test "update_address/2 with invalid data returns error changeset" do
      address = address_fixture()
      assert {:error, %Ecto.Changeset{}} = Location.update_address(address, address_attrs(@invalid_attrs))
      assert address == Location.get_address!(address.id)
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = Location.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Location.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = Location.change_address(address)
    end
  end
end

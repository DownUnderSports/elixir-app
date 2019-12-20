defmodule DownUnderSports.Location.StateTest do
  use DownUnderSports.DataCase, async: true

  alias DownUnderSports.Location

  describe "states" do
    use DownUnderSports.Fixtures, [:state]

    alias DownUnderSports.Location.State

    test "list_states/0 returns all states" do
      state = state_fixture()
      assert Location.list_states() == [state]
    end

    test "get_state!/1 returns the state with given id" do
      state = state_fixture()
      assert Location.get_state!(state.id) == state
    end

    test "create_state/1 with valid data creates a state" do
      assert {:ok, %State{} = state} = Location.create_state(@valid_state_attrs)
      assert state.abbr == "KA"
      assert state.country_code == "USA"
      assert state.full == "Kastate"
      assert state.observes_dst == true
      assert state.tz_offset == -7
    end

    test "create_state/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Location.create_state(@invalid_state_attrs)
    end

    test "update_state/2 with valid data updates the state" do
      state = state_fixture()
      assert {:ok, %State{} = state} = Location.update_state(state, @update_state_attrs)
      assert state.abbr == "VB"
      assert state.country_code == "ABD"
      assert state.full == "Ok State"
      assert state.observes_dst == false
      assert state.tz_offset == 0
    end

    test "update_state/2 with invalid data returns error changeset" do
      state = state_fixture()
      assert {:error, %Ecto.Changeset{}} = Location.update_state(state, @invalid_state_attrs)
      assert state == Location.get_state!(state.id)
    end

    test "delete_state/1 deletes the state" do
      state = state_fixture()
      assert {:ok, %State{}} = Location.delete_state(state)
      assert_raise Ecto.NoResultsError, fn -> Location.get_state!(state.id) end
    end

    test "change_state/1 returns a state changeset" do
      state = state_fixture()
      assert %Ecto.Changeset{} = Location.change_state(state)
    end
  end
end

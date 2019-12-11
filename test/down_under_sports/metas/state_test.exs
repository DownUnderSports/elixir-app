defmodule DownUnderSports.Metas.StateTest do
  use DownUnderSports.DataCase

  alias DownUnderSports.Metas

  describe "states" do
    alias DownUnderSports.Metas.State

    @valid_attrs %{abbr: "KA", country_code: "USA", full: "Kastate", observes_dst: true, tz_offset: -7}
    @update_attrs %{abbr: "vb", country_code: "abd", full: "ok state", observes_dst: false, tz_offset: 0}
    @invalid_attrs %{abbr: nil, country_code: nil, full: nil, observes_dst: nil, tz_offset: nil}

    def state_fixture(attrs \\ %{}) do
      {:ok, state} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Metas.create_state()

      state
    end

    test "list_states/0 returns all states" do
      state = state_fixture()
      assert Metas.list_states() == [state]
    end

    test "get_state!/1 returns the state with given id" do
      state = state_fixture()
      assert Metas.get_state!(state.id) == state
    end

    test "create_state/1 with valid data creates a state" do
      assert {:ok, %State{} = state} = Metas.create_state(@valid_attrs)
      assert state.abbr == "KA"
      assert state.country_code == "USA"
      assert state.full == "Kastate"
      assert state.observes_dst == true
      assert state.tz_offset == -7
    end

    test "create_state/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Metas.create_state(@invalid_attrs)
    end

    test "update_state/2 with valid data updates the state" do
      state = state_fixture()
      assert {:ok, %State{} = state} = Metas.update_state(state, @update_attrs)
      assert state.abbr == "VB"
      assert state.country_code == "ABD"
      assert state.full == "Ok State"
      assert state.observes_dst == false
      assert state.tz_offset == 0
    end

    test "update_state/2 with invalid data returns error changeset" do
      state = state_fixture()
      assert {:error, %Ecto.Changeset{}} = Metas.update_state(state, @invalid_attrs)
      assert state == Metas.get_state!(state.id)
    end

    test "delete_state/1 deletes the state" do
      state = state_fixture()
      assert {:ok, %State{}} = Metas.delete_state(state)
      assert_raise Ecto.NoResultsError, fn -> Metas.get_state!(state.id) end
    end

    test "change_state/1 returns a state changeset" do
      state = state_fixture()
      assert %Ecto.Changeset{} = Metas.change_state(state)
    end
  end
end

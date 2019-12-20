defmodule DownUnderSports.Fixtures do
  @moduledoc """
  This module defines constant fixtures for tests requiring
  access to the associations
  """

  @doc """
  A helper that gets or creates the first seed state
  """
  def state do
    alias DownUnderSports.Location
    alias DownUnderSports.Repo
    quote do
      @valid_state_attrs %{abbr: "KA", country_code: "USA", full: "Kastate", observes_dst: true, tz_offset: -7}
      @update_state_attrs %{abbr: "vb", country_code: "abd", full: "ok state", observes_dst: false, tz_offset: 0}
      @invalid_state_attrs %{abbr: nil, country_code: nil, full: nil, observes_dst: nil, tz_offset: nil}

      def state_fixture(attrs \\ %{}) do
        {:ok, state} =
          attrs
          |> Enum.into(@valid_state_attrs)
          |> Location.create_state()

        state
      end

      def get_or_create_state do
        case Repo.get_by(Location.State, abbr: "AL") do
          nil ->   state_fixture(%{abbr: "AL", country_code: "USA", full: "Alabama", observes_dst: true, tz_offset: -6})
          state -> state
        end
      end
    end
  end

  @doc """
  Apply the `fixtures`.
  """
  defmacro __using__(fixtures) when is_list(fixtures) do
    for fixture <- fixtures, is_atom(fixture),
      do: apply(__MODULE__, fixture, [])
  end
end

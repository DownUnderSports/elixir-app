defmodule DownUnderSports.Metas do
  @moduledoc """
  The Metas context.
  """

  import Ecto.Query, warn: false
  alias DownUnderSports.Repo

  alias DownUnderSports.Metas.Sport

  @doc """
  Returns the list of sports.

  ## Examples

      iex> list_sports()
      [%Sport{}, ...]

  """
  def list_sports do
    Repo.all(Sport)
  end

  @doc """
  Gets a single sport.

  Raises `Ecto.NoResultsError` if the Sport does not exist.

  ## Examples

      iex> get_sport!(123)
      %Sport{}

      iex> get_sport!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sport!(id) when is_integer(id), do: Repo.get!(Sport, id)
  def get_sport!(id) when is_binary(id) do
    trimmed = String.trim(id)
    cond do
      String.match?(trimmed, ~r/^[a-zA-Z]{2,3}$/) ->
        Repo.get_by!(Sport, abbr_gender: String.upcase(trimmed))
      String.match?(trimmed, ~r/[a-zA-Z]/) ->
        Repo.get_by!(
          Sport,
          full_gender:
            String.split(trimmed, " ", trim: true)
            |> Enum.map(fn(word) -> String.capitalize(word) end)
            |> Enum.join(" ")
        )
      true -> Integer.parse(id) |> get_sport!()
    end
  end
  def get_sport!(id), do: get_value!(Sport, id)

  @doc """
  Creates a sport.

  ## Examples

      iex> create_sport(%{field: value})
      {:ok, %Sport{}}

      iex> create_sport(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sport(attrs \\ %{}) do
    %Sport{}
    |> Sport.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sport.

  ## Examples

      iex> update_sport(sport, %{field: new_value})
      {:ok, %Sport{}}

      iex> update_sport(sport, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sport(%Sport{} = sport, attrs) do
    sport
    |> Sport.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Sport.

  ## Examples

      iex> delete_sport(sport)
      {:ok, %Sport{}}

      iex> delete_sport(sport)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sport(%Sport{} = sport) do
    Repo.delete(sport)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sport changes.

  ## Examples

      iex> change_sport(sport)
      %Ecto.Changeset{source: %Sport{}}

  """
  def change_sport(%Sport{} = sport) do
    Sport.changeset(sport, %{})
  end

  alias DownUnderSports.Metas.State

  @doc """
  Returns the list of states.

  ## Examples

      iex> list_states()
      [%State{}, ...]

  """
  def list_states do
    Repo.all(State)
  end

  @doc """
  Gets a single state.

  Raises `Ecto.NoResultsError` if the State does not exist.

  ## Examples

      iex> get_state!(123)
      %State{}

      iex> get_state!(456)
      ** (Ecto.NoResultsError)

  """
  def get_state!(id) when is_integer(id), do: Repo.get!(State, id)
  def get_state!(id) when is_binary(id) do
    trimmed = String.trim(id)
    cond do
      String.match?(trimmed, ~r/^[a-zA-Z]{2}$/) ->
        Repo.get_by!(State, abbr: String.upcase(trimmed))
      String.match?(trimmed, ~r/[a-zA-Z]/) ->
        Repo.get_by!(State, full: String.Format.titleize(trimmed))
      true -> Integer.parse(id) |> get_state!()
    end
  end
  def get_state!(id), do: get_value!(State, id)

  @doc """
  Creates a state.

  ## Examples

      iex> create_state(%{field: value})
      {:ok, %State{}}

      iex> create_state(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_state(attrs \\ %{}) do
    %State{}
    |> State.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a state.

  ## Examples

      iex> update_state(state, %{field: new_value})
      {:ok, %State{}}

      iex> update_state(state, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_state(%State{} = state, attrs) do
    state
    |> State.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a State.

  ## Examples

      iex> delete_state(state)
      {:ok, %State{}}

      iex> delete_state(state)
      {:error, %Ecto.Changeset{}}

  """
  def delete_state(%State{} = state) do
    Repo.delete(state)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking state changes.

  ## Examples

      iex> change_state(state)
      %Ecto.Changeset{source: %State{}}

  """
  def change_state(%State{} = state) do
    State.changeset(state, %{})
  end

  alias DownUnderSports.Metas.Country

  @doc """
  Returns the list of countries.

  ## Examples

      iex> list_countries()
      [%Country{}, ...]

  """
  def list_countries do
    Repo.all(Country)
  end

  @doc """
  Gets a single country.

  Raises `Ecto.NoResultsError` if the Country does not exist.

  ## Examples

      iex> get_country!(123)
      %Country{}

      iex> get_country!(456)
      ** (Ecto.NoResultsError)

  """
  def get_country!(id) when is_integer(id), do: Repo.get!(Country, id)
  def get_country!(id) when is_binary(id) do
    trimmed = String.trim(id)
    cond do
      String.match?(trimmed, ~r/^[a-zA-Z]{3}$/) ->
        Repo.get_by!(Country, code: String.upcase(trimmed))
      String.match?(trimmed, ~r/[a-zA-Z]/) ->
        Repo.get_by!(Country, full: String.Format.titleize(trimmed))
      true -> Integer.parse(id) |> get_country!()
    end
  end
  def get_country!(id), do: get_value!(Country, id)

  @doc """
  Creates a country.

  ## Examples

      iex> create_country(%{field: value})
      {:ok, %Country{}}

      iex> create_country(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_country(attrs \\ %{}) do
    %Country{}
    |> Country.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a country.

  ## Examples

      iex> update_country(country, %{field: new_value})
      {:ok, %Country{}}

      iex> update_country(country, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_country(%Country{} = country, attrs) do
    country
    |> Country.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Country.

  ## Examples

      iex> delete_country(country)
      {:ok, %Country{}}

      iex> delete_country(country)
      {:error, %Ecto.Changeset{}}

  """
  def delete_country(%Country{} = country) do
    Repo.delete(country)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking country changes.

  ## Examples

      iex> change_country(country)
      %Ecto.Changeset{source: %Country{}}

  """
  def change_country(%Country{} = country) do
    Country.changeset(country, %{})
  end

  defp get_value!(model, id) do
    case id do
      {num, ""} -> Repo.get!(model, num)
      _ -> Repo.get!(model, id)
    end
  end
end

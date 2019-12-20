defmodule DownUnderSports.Metas do
  @moduledoc """
  The Metas context.
  """

  import Ecto.Query, warn: false
  alias DownUnderSports.Repo

  alias DownUnderSports.Metas.Sport

  defp get_value!(model, id) do
    case id do
      {num, ""} -> Repo.get!(model, num)
      _ -> Repo.get!(model, id)
    end
  end

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
end

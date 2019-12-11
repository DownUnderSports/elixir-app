defmodule DownUnderSports.Metas.State do
  use Ecto.Schema
  import Ecto.Changeset
  alias DownUnderSports.Repo
  alias DownUnderSports.Metas.Country

  schema "states" do
    field :abbr, :string
    field :country_code, :string, default: "USA"
    field :full, :string
    field :observes_dst, :boolean, default: false
    field :tz_offset, :integer
    belongs_to(
      :country,
      DownUnderSports.Metas.Country,
      [
        foreign_key: :country_code,
        references: :code,
        type: :string,
        define_field: false
      ]
    )

    timestamps()
  end

  @doc false
  def changeset(state, attrs) do
    state
    |> cast(attrs, [:abbr, :full, :country_code, :tz_offset, :observes_dst])
    |> normalize()
    |> validate_required([:abbr, :full, :country_code, :tz_offset, :observes_dst])
    |> validate_length(:abbr, min: 2, max: 3)
    |> unique_constraint(:abbr, name: :states_country_code_abbr_index)
    |> unique_constraint(:full, name: :states_country_code_full_index)
  end

  defp load_country(changeset) do
    country_code = get_field(changeset, :country_code, "USA")
    cond do
      is_binary(country_code) ->
        Repo.get_by(Country, code: String.Format.abbr(country_code, 3))
      true -> nil
    end
  end

  defp normalize(changeset) do
    changeset
    |> normalize_country_code()
    |> normalize_abbr()
    |> normalize_full()
  end

  defp normalize_abbr(changeset) do
    case load_country(changeset) do
      %Country{} = country ->
        normalize_abbr_value(changeset, :abbr, country.state_abbr_length || 2)
      _ -> normalize_abbr_value(changeset, :abbr)
    end
  end

  defp normalize_country_code(changeset) do
    normalize_abbr_value(changeset, :country_code, 3)
  end

  defp normalize_abbr_value(changeset, key), do: normalize_abbr_value(changeset, key, 2)
  defp normalize_abbr_value(changeset, key, len) do
    case fetch_field(changeset, key) do
      {:changes, value} ->
        cond do
          is_binary(value) ->
            put_change(changeset, key, String.Format.abbr(value, len))
          true ->
            changeset
        end
      _ ->
        changeset
    end
  end

  defp normalize_full(changeset) do
    case fetch_field(changeset, :full) do
      {:changes, full} ->
        cond do
          is_binary(full) ->
            put_change(changeset, :full, String.Format.titleize(full))
          true ->
            changeset
        end
      _ ->
        changeset
    end
  end
end

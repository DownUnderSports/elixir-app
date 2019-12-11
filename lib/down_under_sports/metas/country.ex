defmodule DownUnderSports.Metas.Country do
  use Ecto.Schema
  import Ecto.Changeset

  schema "countries" do
    field :address_format, :string
    field :code, :string
    field :full, :string
    field :state_abbr_length, :integer, default: 2

    timestamps()
  end

  @doc false
  def changeset(country, attrs) do
    country
    |> cast(attrs, [:code, :full, :address_format, :state_abbr_length])
    |> normalize()
    |> validate_required([:code, :full, :address_format])
    |> unique_constraint(:code)
    |> unique_constraint(:full)
  end

  defp normalize(changeset) do
    changeset
    |> normalize_code()
    |> normalize_full()
    |> normalize_state_abbr_length()
  end

  defp normalize_code(changeset) do
    case fetch_field(changeset, :code) do
      {:changes, code} ->
        cond do
          is_binary(code) ->
            put_change(changeset, :code, String.Format.abbr(code, 3))
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

  defp normalize_state_abbr_length(changeset) do
    case fetch_field(changeset, :state_abbr_length) do
      {:changes, state_abbr_length} ->
        cond do
          is_binary(state_abbr_length) ->
            put_change(changeset, :state_abbr_length, Integer.parse(state_abbr_length))
          is_integer(state_abbr_length) ->
            changeset
          true ->
            put_change(changeset, :state_abbr_length, 2)
        end
      _ ->
        changeset
    end
  end
end

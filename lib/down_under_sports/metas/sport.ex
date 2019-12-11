defmodule DownUnderSports.Metas.Sport do
  alias __MODULE__
  use Ecto.Schema
  import Ecto.Changeset

  schema "sports" do
    field :abbr, :string
    field :abbr_gender, :string
    field :full, :string
    field :full_gender, :string
    field :is_numbered, :boolean, default: false
    field :is_meta, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(sport, attrs) do
    sport
    |> cast(attrs, [:abbr, :full, :abbr_gender, :full_gender, :is_numbered, :is_meta])
    |> normalize()
    |> validate_required([:abbr, :full, :abbr_gender, :full_gender, :is_numbered, :is_meta])
    |> unique_constraint(:abbr_gender)
    |> unique_constraint(:full_gender)
  end

  defp normalize(changeset) do
    changeset
    |> normalize_abbr()
    |> normalize_abbr_gender()
    |> normalize_full_value(:full)
    |> normalize_full_value(:full_gender)
  end

  defp normalize_abbr(changeset) do
    normalize_abbr_value(changeset, :abbr)
  end

  defp normalize_abbr_gender(changeset) do
    normalize_abbr_value(changeset, :abbr_gender, 3)
  end

  defp normalize_abbr_value(changeset, key), do: normalize_abbr_value(changeset, key, 2)
  defp normalize_abbr_value(changeset, key, len) do
    case fetch_field(changeset, key) do
      {:changes, value} ->
        cond do
          is_binary(value) ->
            put_change(changeset, key, String.Format.abbr(value, len))
          true ->
            generate_value(changeset, key)
        end
      {:data, value} ->
        cond do
          is_binary(value) ->
            changeset
          true ->
            generate_value(changeset, key)
        end
      _ ->
        generate_value(changeset, key)
    end
  end

  defp normalize_full_value(changeset, key) do
    case fetch_field(changeset, key) do
      {:changes, value} ->
        cond do
          is_binary(value) ->
            put_change(changeset, key, String.Format.titleize(value))
          true ->
            generate_value(changeset, key)
        end
      {:data, value} ->
        cond do
          is_binary(value) ->
            changeset
          true ->
            generate_value(changeset, key)
        end
      _ ->
        generate_value(changeset, key)
    end
  end

  defp generate_value(changeset, key) do
    case key do
      :abbr ->
        generate_abbr(changeset)
      :abbr_gender ->
        generate_abbr_gender(changeset)
      :full ->
        generate_full(changeset)
      :full_gender ->
        generate_full_gender(changeset)
    end
  end

  defp generate_abbr(changeset) do
    abbr_gender = get_field(changeset, :abbr_gender, nil)
    cond do
      is_binary(abbr_gender) ->
        abbr_gender
        |> String.slice(-2..-1)
        |> String.Format.abbr()
        |> (&(put_change(changeset, :abbr, &1))).()
      true ->
        changeset
    end
  end

  defp generate_abbr_gender(changeset) do
    abbr = get_field(changeset, :abbr, nil)
    cond do
      is_binary(abbr) ->
        put_change(changeset, :abbr_gender, String.Format.abbr(abbr))
      true ->
        changeset
    end
  end

  defp generate_full(changeset) do
    full_gender = get_field(changeset, :full_gender, nil)
    cond do
      is_binary(full_gender) ->
        full_gender
        |> String.split(~r/^(boys|girls)/i)
        |> Enum.join("")
        |> String.Format.titleize()
        |> (&(put_change(changeset, :full, &1))).()
      true ->
        changeset
    end
  end

  defp generate_full_gender(changeset) do
    full = get_field(changeset, :full, nil)
    cond do
      is_binary(full) ->
        put_change(changeset, :full_gender, String.Format.titleize(full))
      true ->
        changeset
    end
  end
end

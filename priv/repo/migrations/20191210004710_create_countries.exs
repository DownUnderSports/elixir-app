defmodule DownUnderSports.Repo.Migrations.CreateCountries do
  use Ecto.Migration

  def change do
    create table(:countries) do
      add :code, :text, null: false
      add :full, :text, null: false
      add :state_abbr_length, :integer, null: false, default: 2
      add :address_format, :text, null: false

      timestamps()
    end

    create unique_index(:countries, [ :code ])
    create unique_index(:countries, [ :full ])
  end
end

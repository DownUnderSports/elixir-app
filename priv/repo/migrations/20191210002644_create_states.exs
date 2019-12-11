defmodule DownUnderSports.Repo.Migrations.CreateStates do
  use Ecto.Migration

  def change do
    create table(:states) do
      add :abbr, :text, null: false
      add :full, :text, null: false
      add :country_code, :text, null: false, default: "USA"
      add :tz_offset, :integer, null: false
      add :observes_dst, :boolean, default: false, null: false

      timestamps()
    end

    create index(:states, [ :abbr ])
    create index(:states, [ :full ])
    create unique_index(:states, [ :country_code, :abbr ])
    create unique_index(:states, [ :country_code, :full ])

  end
end

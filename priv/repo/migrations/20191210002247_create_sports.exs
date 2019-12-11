defmodule DownUnderSports.Repo.Migrations.CreateSports do
  use Ecto.Migration

  def change do
    create table(:sports) do
      add :abbr, :text, null: false
      add :full, :text, null: false
      add :abbr_gender, :text, null: false
      add :full_gender, :text, null: false
      add :is_numbered, :boolean, default: false, null: false
      add :is_meta, :boolean, default: false, null: false

      timestamps()
    end

    create index(:sports, [ :abbr ])
    create index(:sports, [ :full ])
    create unique_index(:sports, [ :abbr_gender ])
    create unique_index(:sports, [ :full_gender ])

  end
end

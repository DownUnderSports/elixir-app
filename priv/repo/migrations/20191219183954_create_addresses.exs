defmodule DownUnderSports.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :lines, {:array, :citext}
      add :care_of, :text
      add :company, :text
      add :city, :citext
      add :zip, :citext
      add :status, Enums.ConfirmationStatus.type, default: "pending", null: false
      add :state_id, references(:states, on_delete: :delete_all), null: false
      add :tsvector, :tsvector

      timestamps()
    end

    execute ~s"""
      CREATE OR REPLACE FUNCTION address_tsvector_update() returns trigger AS $$
      BEGIN
        new.tsvector :=
          to_tsvector('pg_catalog.english', lower(COALESCE(new.company, '')) || ' ' || f_ciarray_to_text(new.lines) || ' ' || lower(COALESCE(new.city, '')) || ' ' || lower(COALESCE(new.zip, '')));
        return new;
      END
      $$ LANGUAGE plpgsql;
    """, ~s"""
      DROP FUNCTION IF EXISTS address_tsvector_update();
    """

    execute ~s"""
      CREATE TRIGGER address_tsvector_trigger BEFORE INSERT OR UPDATE
      ON addresses FOR EACH ROW EXECUTE PROCEDURE address_tsvector_update();
    """, ~s"""
      DROP TRIGGER IF EXISTS address_tsvector_trigger();
    """

    create index(:addresses, [:state_id])
    create index(:addresses, [:tsvector], name: :address_vector_search, using: "GIN")
  end
end

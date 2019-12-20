defmodule DownUnderSports.Repo.Migrations.CreateConfirmationStatusEnum do
  use Ecto.Migration

  def change do
    Enums.ConfirmationStatus.create_type
  end
end

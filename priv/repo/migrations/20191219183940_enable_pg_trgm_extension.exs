defmodule DownUnderSports.Repo.Migrations.EnablePgTrgmExtension do
  @moduledoc """
  Enable pg_trgm extension if not set
  """

  use Ecto.Migration

  def up do
    execute "CREATE EXTENSION IF NOT EXISTS pg_trgm"
  end
end

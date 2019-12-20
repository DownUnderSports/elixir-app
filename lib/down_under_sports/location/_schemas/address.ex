defmodule DownUnderSports.Location.Address do
  use Ecto.Schema
  import Ecto.Changeset
  alias DownUnderSports.Location.State

  schema "addresses" do
    field :care_of, :string
    field :city, :string
    field :company, :string
    field :lines, {:array, :string}
    field :status, Enums.ConfirmationStatus
    field :zip, :string
    belongs_to :state, State
    field :tsvector, :string, load_in_query: false, virtual: true

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:lines, :care_of, :company, :city, :zip, :status, :state_id])
    |> validate_required([:lines, :care_of, :company, :city, :zip, :state_id, :status])
    |> foreign_key_constraint(:state_id, message: "is required")
  end
end

defmodule PetClinic.PetClinicService.Pet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pets" do
    field :age, :integer
    field :name, :string
    field :sex, Ecto.Enum, values: [:male, :female]
    #field :type, :string
    belongs_to :type, PetClinic.PetClinicService.PetType

    belongs_to :owner, PetClinic.PetClinicService.Owner, on_replace: :nilify
    belongs_to :preferred_expert, PetClinic.PetClinicService.HealthExpert, on_replace: :nilify

    timestamps()
  end

  @doc false
  def changeset(pet, attrs) do
    pet
    |> cast(attrs, [:name, :age, :sex, :type_id])
    |> validate_required([:name, :age, :type_id, :sex])
  end
end

defmodule PetClinic.PetClinicService.HealthExpert do
  use Ecto.Schema
  import Ecto.Changeset

  schema "health_experts" do
    field :age, :integer
    field :email, :string
    field :name, :string
    field :sex, Ecto.Enum, values: [:male, :female]

    has_many :patients, PetClinic.PetClinicService.Pet,
      foreign_key: :preferred_expert_id

    many_to_many :specialities, PetClinic.PetClinicService.PetType,
      join_through: PetClinic.PetClinicService.ExpertSpecialities

    timestamps()
  end

  @doc false
  def changeset(health_expert, attrs) do
    health_expert
    |> cast(attrs, [:name, :age, :email, :specialities, :sex])
    |> validate_required([:name, :age, :email, :specialities, :sex])
  end
end

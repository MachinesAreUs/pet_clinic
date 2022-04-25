defmodule PetClinic.PetClinicService.ExpertSpecialities do
  use Ecto.Schema
  import Ecto.Changeset

  schema "expert_specialities" do
    belongs_to :health_expert, PetClinic.PetClinicService.HealthExpert
    belongs_to :pet_type, PetClinic.PetClinicService.PetType

    timestamps()
  end
end

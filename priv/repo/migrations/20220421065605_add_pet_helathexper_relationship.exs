defmodule PetClinic.Repo.Migrations.AddPetHelathexperRelationship do
  use Ecto.Migration

  def change do
    alter table("pets") do
      add :preferred_expert_id, references("health_experts")
    end
  end
end

defmodule PetClinic.Repo.Migrations.CreateExpertSpecialitiesTable do
  use Ecto.Migration
  alias PetClinic.PetClinicService.ExpertSpecialities
  alias PetClinic.PetClinicService.PetType
  alias PetClinic.Repo
  require Logger

  def change do
    create table("expert_specialities") do
      add :health_expert_id, references("health_experts")
      add :pet_type_id, references("pet_types")

      timestamps()
    end

    flush()

    Ecto.Adapters.SQL.query!(Repo, "select id, specialities from health_experts", [])
    |> then(&(&1.rows))
    |> Enum.each(fn [expert_id, specialities] ->
      Logger.debug("expert_id: #{expert_id}")

      specialities
      |> String.split(",", trim: true)
      |> Enum.map(fn str -> String.trim(str) end)
      |> Enum.each(fn spec ->
        Logger.debug("pet type: #{spec}")

        %PetType{id: type_id} = Repo.get_by(PetType, name: spec)
        Repo.insert(%ExpertSpecialities{health_expert_id: expert_id, pet_type_id: type_id})
      end)
    end)

    alter table("health_experts") do
      remove :specialities
    end
  end
end

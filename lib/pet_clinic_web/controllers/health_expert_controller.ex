defmodule PetClinicWeb.HealthExpertController do
  use PetClinicWeb, :controller

  alias PetClinic.PetClinicService
  alias PetClinic.PetClinicService.HealthExpert

  def index(conn, _params) do
    health_experts = PetClinicService.list_health_experts()
    render(conn, "index.html", health_experts: health_experts)
  end

  def new(conn, _params) do
    changeset = PetClinicService.change_health_expert(%HealthExpert{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"health_expert" => health_expert_params}) do
    case PetClinicService.create_health_expert(health_expert_params) do
      {:ok, health_expert} ->
        conn
        |> put_flash(:info, "Health expert created successfully.")
        |> redirect(to: Routes.health_expert_path(conn, :show, health_expert))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    health_expert = PetClinicService.get_health_expert!(id)
    render(conn, "show.html", health_expert: health_expert)
  end

  def edit(conn, %{"id" => id}) do
    health_expert = PetClinicService.get_health_expert!(id)
    changeset = PetClinicService.change_health_expert(health_expert)
    render(conn, "edit.html", health_expert: health_expert, changeset: changeset)
  end

  def update(conn, %{"id" => id, "health_expert" => health_expert_params}) do
    health_expert = PetClinicService.get_health_expert!(id)

    case PetClinicService.update_health_expert(health_expert, health_expert_params) do
      {:ok, health_expert} ->
        conn
        |> put_flash(:info, "Health expert updated successfully.")
        |> redirect(to: Routes.health_expert_path(conn, :show, health_expert))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", health_expert: health_expert, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    health_expert = PetClinicService.get_health_expert!(id)
    {:ok, _health_expert} = PetClinicService.delete_health_expert(health_expert)

    conn
    |> put_flash(:info, "Health expert deleted successfully.")
    |> redirect(to: Routes.health_expert_path(conn, :index))
  end
end

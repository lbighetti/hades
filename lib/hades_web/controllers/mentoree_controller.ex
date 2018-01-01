defmodule HadesWeb.MentoreeController do
  use HadesWeb, :controller

  alias Hades.Mentorships
  alias Hades.Mentorships.Mentoree

  action_fallback HadesWeb.FallbackController

  def index(conn, _params) do
    mentorees = Mentorships.list_mentorees()
    render(conn, "index.json", mentorees: mentorees)
  end

  def create(conn, %{"mentoree" => mentoree_params}) do
    with {:ok, %Mentoree{} = mentoree} <- Mentorships.create_mentoree(mentoree_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", mentoree_path(conn, :show, mentoree))
      |> render("show.json", mentoree: mentoree)
    end
  end

  def show(conn, %{"id" => id}) do
    mentoree = Mentorships.get_mentoree!(id)
    render(conn, "show.json", mentoree: mentoree)
  end

  def update(conn, %{"id" => id, "mentoree" => mentoree_params}) do
    mentoree = Mentorships.get_mentoree!(id)

    with {:ok, %Mentoree{} = mentoree} <- Mentorships.update_mentoree(mentoree, mentoree_params) do
      render(conn, "show.json", mentoree: mentoree)
    end
  end
end

defmodule Pumarex.Web.ScreeningController do
  use Pumarex.Web, :controller

  alias Pumarex.Theater
  alias Pumarex.Theater.Screening

  plug Guardian.Plug.EnsureAuthenticated, handler: Pumarex.Web.FallbackController
  action_fallback Pumarex.Web.FallbackController

  def index(conn, _params) do
    screenings = Theater.list_screenings()
    render(conn, "index.json", screenings: screenings)
  end

  def create(conn, %{"screening" => screening_params}) do
    with {:ok, %Screening{} = screening} <- Theater.create_screening(screening_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", screening_path(conn, :show, screening))
      |> render("show.json", screening: screening)
    end
  end

  def show(conn, %{"id" => id}) do
    screening = Theater.get_screening!(id)
    render(conn, "show.json", screening: screening)
  end

  def update(conn, %{"id" => id, "screening" => screening_params}) do
    screening = Theater.get_screening!(id)

    with {:ok, %Screening{} = screening} <- Theater.update_screening(screening, screening_params) do
      render(conn, "show.json", screening: screening)
    end
  end

  def delete(conn, %{"id" => id}) do
    screening = Theater.get_screening!(id)
    with {:ok, %Screening{}} <- Theater.delete_screening(screening) do
      send_resp(conn, :no_content, "")
    end
  end
end

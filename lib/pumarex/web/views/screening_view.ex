defmodule Pumarex.Web.ScreeningView do
  use Pumarex.Web, :view
  alias Pumarex.Web.ScreeningView

  def render("index.json", %{screenings: screenings}) do
    %{data: render_many(screenings, ScreeningView, "screening.json")}
  end

  def render("show.json", %{screening: screening}) do
    %{data: render_one(screening, ScreeningView, "screening.json")}
  end

  def render("screening.json", %{screening: screening}) do
    %{id: screening.id,
      screened_at: screening.screened_at}
  end
end

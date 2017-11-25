defmodule Pumarex.Web.ScreeningControllerTest do
  use Pumarex.Web.ConnCase

  alias Pumarex.Theater
  alias Pumarex.Theater.Screening

  @create_attrs %{screened_at: ~N[2010-04-17 14:00:00.000000]}
  @update_attrs %{screened_at: ~N[2011-05-18 15:01:01.000000]}
  @invalid_attrs %{screened_at: nil}

  def fixture(:screening) do
    {:ok, screening} = Theater.create_screening(@create_attrs)
    screening
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get(conn, screening_path(conn, :index))
    assert json_response(conn, 200)["data"] == []
  end

  test "creates screening and renders screening when data is valid", %{conn: conn} do
    conn = post(conn, screening_path(conn, :create), screening: @create_attrs)
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get(conn, screening_path(conn, :show, id))

    assert json_response(conn, 200)["data"] == %{
             "id" => id,
             "screened_at" => ~N[2010-04-17 14:00:00.000000]
           }
  end

  test "does not create screening and renders errors when data is invalid", %{conn: conn} do
    conn = post(conn, screening_path(conn, :create), screening: @invalid_attrs)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen screening and renders screening when data is valid", %{conn: conn} do
    %Screening{id: id} = screening = fixture(:screening)
    conn = put(conn, screening_path(conn, :update, screening), screening: @update_attrs)
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get(conn, screening_path(conn, :show, id))

    assert json_response(conn, 200)["data"] == %{
             "id" => id,
             "screened_at" => ~N[2011-05-18 15:01:01.000000]
           }
  end

  test "does not update chosen screening and renders errors when data is invalid", %{conn: conn} do
    screening = fixture(:screening)
    conn = put(conn, screening_path(conn, :update, screening), screening: @invalid_attrs)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen screening", %{conn: conn} do
    screening = fixture(:screening)
    conn = delete(conn, screening_path(conn, :delete, screening))
    assert response(conn, 204)

    assert_error_sent(404, fn ->
      get(conn, screening_path(conn, :show, screening))
    end)
  end
end

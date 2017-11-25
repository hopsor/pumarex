defmodule Pumarex.Web.RoomControllerTest do
  use Pumarex.Web.ConnCase

  alias Pumarex.Theater
  alias Pumarex.Theater.Room

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:room) do
    {:ok, room} = Theater.create_room(@create_attrs)
    room
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get(conn, room_path(conn, :index))
    assert json_response(conn, 200)["data"] == []
  end

  test "creates room and renders room when data is valid", %{conn: conn} do
    conn = post(conn, room_path(conn, :create), room: @create_attrs)
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get(conn, room_path(conn, :show, id))
    assert json_response(conn, 200)["data"] == %{"id" => id, "name" => "some name"}
  end

  test "does not create room and renders errors when data is invalid", %{conn: conn} do
    conn = post(conn, room_path(conn, :create), room: @invalid_attrs)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen room and renders room when data is valid", %{conn: conn} do
    %Room{id: id} = room = fixture(:room)
    conn = put(conn, room_path(conn, :update, room), room: @update_attrs)
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get(conn, room_path(conn, :show, id))
    assert json_response(conn, 200)["data"] == %{"id" => id, "name" => "some updated name"}
  end

  test "does not update chosen room and renders errors when data is invalid", %{conn: conn} do
    room = fixture(:room)
    conn = put(conn, room_path(conn, :update, room), room: @invalid_attrs)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen room", %{conn: conn} do
    room = fixture(:room)
    conn = delete(conn, room_path(conn, :delete, room))
    assert response(conn, 204)

    assert_error_sent(404, fn ->
      get(conn, room_path(conn, :show, room))
    end)
  end
end

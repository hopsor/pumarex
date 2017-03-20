module RoomList.Update exposing (..)

import RoomList.Messages exposing (..)
import Model exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        FetchRooms (Ok response) ->
            { model | roomList = Success response } ! []

        FetchRooms (Err error) ->
            { model | roomList = Failure "Something went wrong" } ! []

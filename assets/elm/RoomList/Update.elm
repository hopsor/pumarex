module RoomList.Update exposing (..)

import RoomList.Messages exposing (..)
import Model exposing (..)
import Navigation
import Routing exposing (toPath, Route(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        FetchRooms (Ok response) ->
            { model | roomList = Success response } ! []

        FetchRooms (Err error) ->
            { model | roomList = Failure "Something went wrong" } ! []

        GoToNewRoom ->
            model ! [ Navigation.newUrl (toPath NewRoomRoute) ]

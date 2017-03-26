module RoomList.Update exposing (..)

import RoomList.Messages exposing (..)
import RoomList.Commands exposing (deleteRoom)
import Model exposing (..)
import Navigation
import Routing exposing (toPath, Route(..))
import List.Extra exposing (filterNot)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        FetchRooms (Ok response) ->
            { model | roomList = Success response } ! []

        FetchRooms (Err error) ->
            { model | roomList = Failure "Something went wrong" } ! []

        HandleDeleteRoomClick room ->
            model ! [ deleteRoom room ]

        GoToNewRoom ->
            model ! [ Navigation.newUrl (toPath NewRoomRoute) ]

        RoomDeleted (Ok deletedRoom) ->
            let
                updatedRoomList =
                    case model.roomList of
                        Success result ->
                            filterNot (\r -> deletedRoom.id == r.id) result

                        _ ->
                            []
            in
                { model | roomList = Success updatedRoomList } ! []

        RoomDeleted (Err error) ->
            let
                _ =
                    Debug.log "Error deleting room " error
            in
                model ! []

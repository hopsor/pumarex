module RoomList.Commands exposing (..)

import DataModel exposing (Session, Room)
import Decoders exposing (roomListDecoder)
import Http
import Json.Decode as JD
import Json.Encode as JE
import RoomList.Messages exposing (Msg(..))
import Helpers exposing (getRequest, deleteRequest)


fetchRooms : Session -> Cmd Msg
fetchRooms session =
    let
        request =
            getRequest session "/api/rooms" roomListDecoder
    in
        Http.send FetchRooms request


deleteRoom : Session -> Room -> Cmd Msg
deleteRoom session room =
    let
        request =
            deleteRequest session <| "/api/rooms/" ++ (toString room.id)
    in
        Http.send (RoomDeleted room) request

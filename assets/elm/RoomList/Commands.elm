module RoomList.Commands exposing (..)

import Decoders exposing (roomListDecoder)
import Http
import RoomList.Messages exposing (Msg(..))


fetchRooms : Cmd Msg
fetchRooms =
    let
        apiUrl =
            "/api/rooms"

        request =
            Http.get apiUrl roomListDecoder
    in
        Http.send FetchRooms request

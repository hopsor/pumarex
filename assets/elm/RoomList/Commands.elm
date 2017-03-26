module RoomList.Commands exposing (..)

import Model exposing (Room)
import Decoders exposing (roomListDecoder)
import Http
import Json.Decode as JD
import Json.Encode as JE
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


deleteRoom : Room -> Cmd Msg
deleteRoom room =
    let
        apiUrl =
            "/api/rooms/" ++ (toString room.id)

        request =
            Http.request
                { method = "DELETE"
                , headers = []
                , url = apiUrl
                , body = Http.emptyBody
                , expect = Http.expectJson (JD.succeed room)
                , timeout = Nothing
                , withCredentials = False
                }
    in
        Http.send RoomDeleted request

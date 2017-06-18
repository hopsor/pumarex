module RoomList.Messages exposing (..)

import Http
import DataModel exposing (Room, RoomList)


type Msg
    = NoOp
    | FetchRooms (Result Http.Error RoomList)
    | HandleDeleteRoomClick Room
    | RoomDeleted Room (Result Http.Error String)
    | GoToNewRoom

module RoomList.Messages exposing (..)

import Http
import Model exposing (Room, RoomList)


type Msg
    = NoOp
    | FetchRooms (Result Http.Error RoomList)
    | HandleDeleteRoomClick Room
    | RoomDeleted (Result Http.Error Room)
    | GoToNewRoom

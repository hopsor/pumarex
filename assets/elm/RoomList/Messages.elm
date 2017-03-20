module RoomList.Messages exposing (..)

import Http
import Model exposing (RoomList)


type Msg
    = NoOp
    | FetchRooms (Result Http.Error RoomList)

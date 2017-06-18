module RoomForm.Messages exposing (..)

import Http
import DataModel exposing (Room)


type Msg
    = NoOp
    | HandleNameChanged String
    | HandleRowsChanged String
    | HandleColumnsChanged String
    | HandleSeatSpotClick Int Int
    | HandleFillRowButtonClick Int
    | HandleEmptyRowButtonClick Int
    | HandleFillRoomButtonClick
    | HandleSubmit
    | RoomCreated (Result Http.Error Room)

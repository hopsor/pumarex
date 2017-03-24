module RoomForm.Messages exposing (..)


type Msg
    = NoOp
    | HandleNameChanged String
    | HandleRowsChanged String
    | HandleColumnsChanged String
    | HandleSeatSpotClick Int Int
    | HandleFillRowButtonClick Int
    | HandleEmptyRowButtonClick Int
    | HandleFillRoomButtonClick

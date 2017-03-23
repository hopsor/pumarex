module RoomForm.Messages exposing (..)


type Msg
    = NoOp
    | HandleRowsChanged String
    | HandleColumnsChanged String
    | HandleSeatSpotClick Int Int

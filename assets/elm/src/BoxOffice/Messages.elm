module BoxOffice.Messages exposing (..)

import Model exposing (ScreeningList, Seat)
import Http
import Dict exposing (Dict)
import Json.Decode as JD


type Msg
    = NoOp
    | FetchScreenings (Result Http.Error ScreeningList)
    | ScreeningChanged String
    | UpdatePresence (Dict String (List JD.Value))
    | RoomLoaded JD.Value
    | LockedSeats JD.Value
    | SoldSeats JD.Value
    | SeatClicked Seat
    | SellTickets

module BoxOffice.Messages exposing (..)

import DataModel exposing (ScreeningList)
import Http


type Msg
    = NoOp
    | FetchScreenings (Result Http.Error ScreeningList)
    | ScreeningChanged String

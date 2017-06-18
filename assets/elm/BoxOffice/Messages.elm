module BoxOffice.Messages exposing (..)

import Model exposing (ScreeningList)
import Http


type Msg
    = NoOp
    | FetchScreenings (Result Http.Error ScreeningList)
    | ScreeningChanged String

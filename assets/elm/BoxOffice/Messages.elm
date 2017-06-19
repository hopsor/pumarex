module BoxOffice.Messages exposing (..)

import Model exposing (ScreeningList)
import Http
import Dict
import Json.Decode as JD


type Msg
    = NoOp
    | FetchScreenings (Result Http.Error ScreeningList)
    | ScreeningChanged String
    | UpdatePresence (Dict String (List JD.Value))

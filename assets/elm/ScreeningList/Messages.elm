module ScreeningList.Messages exposing (..)

import Http
import DataModel exposing (Screening, ScreeningList)


type Msg
    = NoOp
    | FetchScreenings (Result Http.Error ScreeningList)
    | HandleDeleteScreeningClick Screening
    | ScreeningDeleted Screening (Result Http.Error String)
    | GoToNewScreening

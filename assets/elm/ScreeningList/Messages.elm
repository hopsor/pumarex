module ScreeningList.Messages exposing (..)

import Http
import Model exposing (Screening, ScreeningList)


type Msg
    = NoOp
    | FetchScreenings (Result Http.Error ScreeningList)
    | HandleDeleteScreeningClick Screening
    | ScreeningDeleted Screening (Result Http.Error String)
    | GoToNewScreening

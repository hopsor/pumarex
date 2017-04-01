module ScreeningForm.Messages exposing (..)

import Http
import Model exposing (Screening)


type Msg
    = NoOp
    | FieldChange String String
    | ScreeningCreated (Result Http.Error Screening)
    | Save

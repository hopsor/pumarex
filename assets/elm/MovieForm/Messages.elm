module MovieForm.Messages exposing (..)

import Http
import DataModel exposing (Movie)


type Msg
    = NoOp
    | FieldChange String String
    | MovieCreated (Result Http.Error Movie)
    | Save

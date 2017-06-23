module MovieForm.Messages exposing (..)

import Http
import Model exposing (Movie)


type Msg
    = NoOp
    | FieldChange String String
    | MovieCreated (Result Http.Error Movie)
    | MovieFetched (Result Http.Error Movie)
    | Save

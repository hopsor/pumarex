module MoviePage.Messages exposing (..)

import Http
import Model exposing (Movie)


type Msg
    = NoOp
    | LoadMovie (Result Http.Error Movie)

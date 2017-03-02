module MovieList.Update exposing (..)

import MovieList.Types exposing (..)
import Model exposing (..)
import Navigation

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

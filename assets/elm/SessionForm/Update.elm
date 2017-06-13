module SessionForm.Update exposing (..)

import SessionForm.Messages exposing (..)
import Model exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        Authenticate ->
            model ! []

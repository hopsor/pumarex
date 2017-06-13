module SessionForm.View exposing (..)

import SessionForm.Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)


formView : Model -> Html Msg
formView model =
    div
        [ class "session" ]
        [ p [] [ text "HEHE" ] ]

module RoomForm.View exposing (..)

import RoomForm.Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)


formView : Model -> Html Msg
formView model =
    p [] [ text "Room Form" ]

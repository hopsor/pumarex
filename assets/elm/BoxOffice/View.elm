module BoxOffice.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import BoxOffice.Messages exposing (..)


boxOfficeView : Model -> Html Msg
boxOfficeView model =
    p [] [ text "BOX OFFICE" ]

module Home.View exposing (..)

import Home.Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)

homeView : Model -> Html Msg
homeView model =
    p [] [ text "Home" ]

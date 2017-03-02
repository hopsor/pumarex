module Home.View exposing (..)

import Home.Types exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)

homeView : Model -> Html Msg
homeView model =
    p [] [ text "Home" ]

module MovieList.View exposing (..)

import MovieList.Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)

indexView : Model -> Html Msg
indexView model =
    p [] [ text "MovieList" ]

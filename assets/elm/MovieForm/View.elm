module MovieForm.View exposing (..)

import MovieForm.Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)


formView : Model -> Html Msg
formView model =
    div []
        [ p [] [ text "Movie Form" ]
        ]

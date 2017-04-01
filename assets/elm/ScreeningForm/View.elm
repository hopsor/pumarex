module ScreeningForm.View exposing (..)

import ScreeningForm.Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import String.Extra exposing (humanize)


formView : Model -> Html Msg
formView model =
    Html.form
        [ id "movie_form" ]
        [ h1 [] [ text "New Screening" ] ]

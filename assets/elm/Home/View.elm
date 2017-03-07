module Home.View exposing (..)

import Home.Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)


homeView : Model -> Html Msg
homeView model =
    div [ id "home" ]
        [ div [ class "brand" ]
            [ div [ class "seats" ] []
            , h1 [] [ text "Pumarex" ]
            , h2 [] [ text "An open source movie theater app built with Phoenix and Elm." ]
            ]
        ]

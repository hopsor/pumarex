module MovieForm.View exposing (..)

import MovieForm.Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)


formView : Model -> Html Msg
formView model =
    div []
        [ div [ class "field" ] [ input [ type_ "text", onInput Title ] [] ]
        , div [ class "field" ] [ input [ type_ "number", onInput Year ] [] ]
        , div [ class "field" ] [ input [ type_ "number", onInput Duration ] [] ]
        , div [ class "field" ] [ input [ type_ "text", onInput Director ] [] ]
        , div [ class "field" ] [ input [ type_ "text", onInput Cast ] [] ]
        , div [ class "field" ] [ input [ type_ "text", onInput Overview ] [] ]
        , div [ class "field" ] [ input [ type_ "text", onInput Poster ] [] ]
        ]

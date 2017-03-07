module MovieForm.View exposing (..)

import MovieForm.Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)


formView : Model -> Html Msg
formView model =
    div []
        [ div [ class "field" ] [ input [ type_ "text", onInput (FieldChange "title") ] [] ]
        , div [ class "field" ] [ input [ type_ "number", onInput (FieldChange "year") ] [] ]
        , div [ class "field" ] [ input [ type_ "number", onInput (FieldChange "duration") ] [] ]
        , div [ class "field" ] [ input [ type_ "text", onInput (FieldChange "director") ] [] ]
        , div [ class "field" ] [ input [ type_ "text", onInput (FieldChange "cast") ] [] ]
        , div [ class "field" ] [ input [ type_ "text", onInput (FieldChange "overview") ] [] ]
        , div [ class "field" ] [ input [ type_ "text", onInput (FieldChange "poster") ] [] ]
        ]

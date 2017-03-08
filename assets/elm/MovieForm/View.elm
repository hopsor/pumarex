module MovieForm.View exposing (..)

import MovieForm.Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import String.Extra exposing (humanize)


formView : Model -> Html Msg
formView model =
    Html.form [ id "movie_form" ]
        [ h1 [] [ text "New Movie" ]
        , div [ class "group" ]
            [ div [ class "column" ]
                [ regularField "title" "text"
                , regularField "year" "number"
                , regularField "duration" "number"
                , regularField "poster" "text"
                , div [ class "actions" ]
                    [ button [ type_ "button", onClick Save ] [ text "Save" ] ]
                ]
            , div [ class "column" ]
                [ regularField "director" "text"
                , regularField "cast" "text"
                , textareaField "overview"
                ]
            ]
        ]


regularField : String -> String -> Html Msg
regularField fieldName fieldType =
    div [ class "field" ]
        [ label [ for fieldName ] [ text (humanize fieldName) ]
        , input [ type_ fieldType, class fieldName, name fieldName, required True, onInput (FieldChange fieldName) ] []
        ]


textareaField : String -> Html Msg
textareaField fieldName =
    div [ class "field" ]
        [ label [ for fieldName ] [ text (humanize fieldName) ]
        , textarea [ class fieldName, name fieldName, required True, onInput (FieldChange fieldName) ] []
        ]

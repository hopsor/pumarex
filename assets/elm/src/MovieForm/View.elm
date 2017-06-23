module MovieForm.View exposing (..)

import MovieForm.Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import String.Extra exposing (humanize)
import Dict


formView : Model -> Html Msg
formView model =
    Html.form [ id "movie_form", onSubmit Save ]
        [ h1 [] [ formHeader model.movieForm ]
        , div [ class "group" ]
            [ div [ class "column" ]
                [ regularField model.movieForm "title" "text"
                , regularField model.movieForm "year" "number"
                , regularField model.movieForm "duration" "number"
                , regularField model.movieForm "poster" "text"
                , div [ class "actions" ]
                    [ button [ type_ "submit" ] [ text "Save" ] ]
                ]
            , div [ class "column" ]
                [ regularField model.movieForm "director" "text"
                , regularField model.movieForm "cast" "text"
                , textareaField "overview"
                ]
            ]
        ]


formHeader : MovieForm -> Html Msg
formHeader movieForm =
    case Dict.get "id" movieForm of
        Just movieId ->
            text "Edit Movie"

        Nothing ->
            text "New Movie"


regularField : MovieForm -> String -> String -> Html Msg
regularField movieForm fieldName fieldType =
    div
        [ class "field" ]
        [ label
            [ for fieldName ]
            [ text (humanize fieldName) ]
        , input
            [ type_ fieldType
            , class fieldName
            , name fieldName
            , required True
            , onInput (FieldChange fieldName)
            , value (Maybe.withDefault "" (Dict.get fieldName movieForm))
            ]
            []
        ]


textareaField : String -> Html Msg
textareaField fieldName =
    div
        [ class "field" ]
        [ label
            [ for fieldName ]
            [ text (humanize fieldName) ]
        , textarea
            [ class fieldName
            , name fieldName
            , required True
            , onInput (FieldChange fieldName)
            ]
            []
        ]

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
        [ h1 [] [ text "New Screening" ]
        , div
            [ class "field" ]
            [ input
                [ type_ "date", placeholder "Date" ]
                []
            , input
                [ type_ "text", placeholder "HH:MM (24h format)" ]
                []
            ]
        , div
            [ class "field" ]
            [ select
                []
                (movieOptions model)
            ]
        , div
            [ class "field" ]
            [ select
                []
                []
            ]
        , div
            [ class "actions" ]
            [ button
                [ type_ "button", onClick Save ]
                [ text "Save" ]
            ]
        ]


movieOptions : Model -> List (Html Msg)
movieOptions model =
    case model.movieList of
        Success result ->
            let
                movieOption : Movie -> Html Msg
                movieOption =
                    \movie ->
                        option
                            [ value (toString movie.id) ]
                            [ text movie.title ]
            in
                List.map movieOption result.entries

        _ ->
            [ option
                [ value "" ]
                [ text "Not loaded" ]
            ]

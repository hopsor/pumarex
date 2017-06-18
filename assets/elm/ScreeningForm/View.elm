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
                [ type_ "date", placeholder "Date", onInput (FieldChange "date") ]
                []
            , input
                [ type_ "text", placeholder "HH:MM (24h format)", onInput (FieldChange "time") ]
                []
            ]
        , div
            [ class "field" ]
            [ select
                [ onInput (FieldChange "movie_id") ]
                (movieOptions model)
            ]
        , div
            [ class "field" ]
            [ select
                [ onInput (FieldChange "room_id") ]
                (roomOptions model)
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
    case model.screeningForm.movies of
        Success result ->
            let
                emptyOption =
                    option [ value "" ] [ text "Choose a movie" ]

                movieOption : Movie -> Html Msg
                movieOption =
                    \movie ->
                        option
                            [ value (toString movie.id) ]
                            [ text movie.title ]
            in
                [ emptyOption ] ++ List.map movieOption result.entries

        _ ->
            [ option
                [ value "" ]
                [ text "Not loaded" ]
            ]


roomOptions : Model -> List (Html Msg)
roomOptions model =
    case model.screeningForm.rooms of
        Success result ->
            let
                emptyOption =
                    option [ value "" ] [ text "Choose a room" ]

                roomOption : Room -> Html Msg
                roomOption =
                    \room ->
                        option
                            [ value (toString room.id) ]
                            [ text room.name ]
            in
                [ emptyOption ] ++ List.map roomOption result

        _ ->
            [ option
                [ value "" ]
                [ text "Not loaded" ]
            ]

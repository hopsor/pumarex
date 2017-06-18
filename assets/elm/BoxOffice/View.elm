module BoxOffice.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import DataModel exposing (RemoteData(..), Screening, ScreeningList)
import BoxOffice.Messages exposing (..)


boxOfficeView : Model -> Html Msg
boxOfficeView model =
    Html.form
        [ id "box_office" ]
        [ h1 [] [ text "Box Office" ]
        , div
            [ class "field" ]
            [ select
                [ onInput ScreeningChanged ]
                (screeningOptions model.boxOffice.availableScreenings)
            ]
        ]


screeningOptions : RemoteData String ScreeningList -> List (Html Msg)
screeningOptions availableScreenings =
    case availableScreenings of
        Success result ->
            let
                emptyOption =
                    option [ value "" ] [ text "Choose a screening" ]

                screeningOption : Screening -> Html Msg
                screeningOption =
                    \screening ->
                        option
                            [ value (toString screening.id) ]
                            [ text screening.movie.title ]
            in
                [ emptyOption ] ++ List.map screeningOption result

        _ ->
            [ option
                [ value "" ]
                [ text "Not loaded" ]
            ]

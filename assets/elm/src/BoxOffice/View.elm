module BoxOffice.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import BoxOffice.Messages exposing (..)
import Dict exposing (Dict)


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
        , connectedTicketSellersView model
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


connectedTicketSellersView : Model -> Html Msg
connectedTicketSellersView model =
    let
        sellerView : ( String, List JD.Value ) -> Html Msg
        sellerView =
            \( sellerId, jdValue ) ->
                div [ class "connected-seller" ] [ text sellerId ]

        sellersViews =
            model.boxOffice.presence
                |> Dict.toList
                |> List.map sellerView
    in
        case model.boxOffice.selectedScreening of
            Just screening ->
                div
                    []
                    [ h2
                        []
                        [ text "Connected Sellers" ]
                    , div
                        []
                        sellersViews
                    ]

            Nothing ->
                text ""

module BoxOffice.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import BoxOffice.Messages exposing (..)
import Decoders exposing (ticketSellerDecoder)
import Dict exposing (Dict)
import Json.Decode as JD
import Json.Encode as JE


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
        , connectedUsersView model
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


connectedUsersView : Model -> Html Msg
connectedUsersView model =
    case model.boxOffice.selectedScreening of
        Just screening ->
            div
                []
                [ h2
                    []
                    [ text "Connected Sellers" ]
                , div
                    [ class "online-ticket-sellers" ]
                    (List.map connectedUserView (Dict.toList model.boxOffice.presence))
                ]

        Nothing ->
            text ""



-- TODO: Find a better way of doing what is on let block


connectedUserView : ( String, List JD.Value ) -> Html Msg
connectedUserView ( userId, payload ) =
    let
        userData =
            List.head payload

        value =
            case userData of
                Just ud ->
                    ud

                Nothing ->
                    JE.object []

        user =
            case JD.decodeValue ticketSellerDecoder value of
                Ok user ->
                    user

                _ ->
                    TicketSeller "" "" ""
    in
        div
            [ class "ticket-seller" ]
            [ img
                [ src user.avatar ]
                []
            , text user.fullName
            ]

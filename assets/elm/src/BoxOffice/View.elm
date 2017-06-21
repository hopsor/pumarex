module BoxOffice.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import BoxOffice.Messages exposing (..)
import BoxOffice.Helpers exposing (..)
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
        , roomViewWrapper model
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
            , span
                []
                [ text user.fullName ]
            ]


roomViewWrapper : Model -> Html Msg
roomViewWrapper model =
    case model.boxOffice.room of
        Just room ->
            div
                [ id "room_view_wrapper" ]
                [ roomView room model.boxOffice model.session
                , roomLegendView
                ]

        Nothing ->
            text "Room not loaded"


roomLegendView : Html Msg
roomLegendView =
    ul
        [ class "room-legend" ]
        [ li
            [ class "sold" ]
            [ text "Sold" ]
        , li
            [ class "locked-by-you" ]
            [ text "Locked by you" ]
        , li
            [ class "locked-by-someone" ]
            [ text "Locked by someone" ]
        ]


roomView : Room -> BoxOffice -> Session -> Html Msg
roomView room boxOffice session =
    let
        rows =
            roomRowsCount room

        columns =
            roomColumnsCount room

        rowElements =
            rows
                |> List.range 1
                |> List.map (\row -> rowView room row columns boxOffice session)
    in
        div
            [ class "room" ]
            rowElements


rowView : Room -> Int -> Int -> BoxOffice -> Session -> Html Msg
rowView room row totalColumns boxOffice session =
    let
        columns =
            List.range 1 totalColumns
    in
        div
            [ class "room-row" ]
            (List.map (\column -> seatView room row column boxOffice session) columns)


seatView : Room -> Int -> Int -> BoxOffice -> Session -> Html Msg
seatView room row column boxOffice session =
    div
        [ class (seatClasses row column boxOffice session)
        , onClick (SeatClicked row column)
        ]
        []

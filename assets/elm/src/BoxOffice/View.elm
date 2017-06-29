module BoxOffice.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import BoxOffice.Messages exposing (..)
import BoxOffice.Helpers exposing (..)
import Decoders exposing (ticketSellerDecoder)
import Dict exposing (Dict)
import List.Extra as ListExtra
import Json.Decode as JD
import Json.Encode as JE


boxOfficeView : Model -> Html Msg
boxOfficeView model =
    let
        body =
            case model.boxOffice.selectedScreening of
                Just _ ->
                    [ ticketsWrapper model
                    , roomViewWrapper model
                    ]

                Nothing ->
                    []
    in
        Html.form
            [ id "box_office" ]
            [ div
                [ class "box-office-header" ]
                [ screeningSelectorWrapper model
                , connectedUsersView model
                ]
            , div
                [ class "box-office-body" ]
                body
            ]


screeningSelectorWrapper : Model -> Html Msg
screeningSelectorWrapper model =
    div
        [ class "field" ]
        [ h2
            []
            [ text "Screening" ]
        , select
            [ onInput ScreeningChanged ]
            (screeningOptions model.boxOffice.availableScreenings)
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
                            [ text screening.name ]
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
                [ class "connected-sellers-wrapper" ]
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
                    TicketSeller 0 "" "" ""
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

        footer =
            List.range 1 columns
                |> List.map (\colNumber -> div [ class "column-footer" ] [ text (toString colNumber) ])
                |> div [ class "footer" ]
    in
        div
            [ class "room" ]
            (rowElements ++ [ footer ])


rowView : Room -> Int -> Int -> BoxOffice -> Session -> Html Msg
rowView room row totalColumns boxOffice session =
    let
        columns =
            List.range 1 totalColumns

        rowCounter =
            div
                [ class "row-counter" ]
                [ text (toString row) ]

        rowColumns =
            List.map (\column -> seatView room row column boxOffice session) columns
    in
        div
            [ class "room-row" ]
            ([ rowCounter ] ++ rowColumns)


seatView : Room -> Int -> Int -> BoxOffice -> Session -> Html Msg
seatView room row column boxOffice session =
    let
        seat =
            boxOffice.room
                |> Maybe.andThen .seats
                |> Maybe.withDefault []
                |> getSeatAt row column
    in
        case seat of
            Just seat ->
                div
                    [ class (seatClasses seat boxOffice session)
                    , onClick (SeatClicked seat)
                    ]
                    []

            Nothing ->
                div
                    [ class "floor" ]
                    []


ticketsWrapper : Model -> Html Msg
ticketsWrapper model =
    let
        fSelectSeats =
            \ls -> ls.userId == model.session.id

        selectedSeats =
            model.boxOffice.lockedSeats
                |> List.filter fSelectSeats
                |> List.length

        buttonDiv =
            if selectedSeats > 0 then
                button
                    [ type_ "button", onClick SellTickets ]
                    [ text ("Sell " ++ (toString selectedSeats) ++ " tickets") ]
            else
                text ""
    in
        div
            [ class "tickets-wrapper" ]
            [ (saleWrapper model), buttonDiv ]


saleWrapper : Model -> Html Msg
saleWrapper model =
    let
        saleTopInfo =
            case model.boxOffice.selectedScreening of
                Just screening ->
                    [ div
                        [ class "sale-header" ]
                        [ text "Pumarex" ]
                    , div
                        [ class "cover", style [ ( "backgroundImage", "url(" ++ screening.movie.poster ++ ")" ) ] ]
                        []
                    , div
                        [ class "screening-details" ]
                        [ h2
                            []
                            [ text screening.movie.title ]
                        , h3
                            []
                            [ text (screening.room.name ++ " - " ++ screening.formattedDate) ]
                        ]
                    ]

                Nothing ->
                    [ text "" ]
    in
        div
            [ class "sale" ]
            (saleTopInfo ++ (tickets model))


tickets : Model -> List (Html Msg)
tickets model =
    List.map (\lockedSeat -> ticketView model lockedSeat) model.boxOffice.lockedSeats


ticketView : Model -> LockedSeat -> Html Msg
ticketView model lockedSeat =
    let
        seats =
            model.boxOffice.room
                |> Maybe.andThen .seats
                |> Maybe.withDefault []

        seat =
            ListExtra.find (\seat -> seat.id == lockedSeat.seatId) seats
    in
        case seat of
            Just seat ->
                div
                    [ class "ticket" ]
                    [ div
                        [ class "row" ]
                        [ div
                            [ class "title" ]
                            [ text "Row" ]
                        , div
                            [ class "value" ]
                            [ text (toString seat.row) ]
                        ]
                    , div
                        [ class "column" ]
                        [ div
                            [ class "title" ]
                            [ text "Seat" ]
                        , div
                            [ class "value" ]
                            [ text (toString seat.column) ]
                        ]
                    ]

            Nothing ->
                text ""

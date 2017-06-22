module BoxOffice.Update exposing (..)

import BoxOffice.Messages exposing (..)
import BoxOffice.Helpers exposing (..)
import Model exposing (..)
import List.Extra as ListExtra
import Phoenix
import Phoenix.Channel as Channel
import Phoenix.Push as Push
import Dict exposing (Dict)
import Json.Decode as JD
import Json.Encode as JE
import Decoders exposing (roomDecoder, lockedSeatListDecoder)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        FetchScreenings (Ok response) ->
            let
                oldBoxOffice =
                    model.boxOffice

                updatedBoxOffice =
                    { oldBoxOffice | availableScreenings = Success response }
            in
                { model | boxOffice = updatedBoxOffice } ! []

        FetchScreenings (Err error) ->
            let
                oldBoxOffice =
                    model.boxOffice

                newBoxOffice =
                    { oldBoxOffice | availableScreenings = Failure "Something went wrong" }
            in
                { model | boxOffice = newBoxOffice } ! []

        ScreeningChanged value ->
            case model.boxOffice.availableScreenings of
                Success screeningList ->
                    let
                        oldBoxOffice =
                            model.boxOffice

                        screeningId =
                            Result.withDefault 0 (String.toInt value)

                        selectedScreening =
                            ListExtra.find (\screening -> screening.id == screeningId) screeningList

                        newBoxOffice =
                            { oldBoxOffice | selectedScreening = selectedScreening, presence = Dict.empty }
                    in
                        { model | boxOffice = newBoxOffice } ! []

                _ ->
                    model ! []

        UpdatePresence presenceState ->
            let
                oldBoxOffice =
                    model.boxOffice

                newBoxOffice =
                    { oldBoxOffice | presence = presenceState }
            in
                { model | boxOffice = newBoxOffice } ! []

        RoomLoaded payload ->
            let
                room =
                    case JD.decodeValue roomDecoder payload of
                        Ok decodedRoom ->
                            Just decodedRoom

                        _ ->
                            Nothing

                oldBoxOffice =
                    model.boxOffice

                newBoxOffice =
                    { oldBoxOffice | room = room }
            in
                { model | boxOffice = newBoxOffice } ! []

        LockedSeats payload ->
            let
                payloadDecoder =
                    JD.field "locked_seats" lockedSeatListDecoder

                ls =
                    JD.decodeValue payloadDecoder payload

                lockedSeats =
                    case ls of
                        Ok seats ->
                            seats

                        _ ->
                            []

                oldBoxOffice =
                    model.boxOffice

                newBoxOffice =
                    { oldBoxOffice | lockedSeats = lockedSeats }
            in
                { model | boxOffice = newBoxOffice } ! []

        SoldSeats payload ->
            let
                payloadDecoder =
                    JD.field "sold_seats" (JD.list (JD.int))

                soldSeats =
                    case JD.decodeValue payloadDecoder payload of
                        Ok seatIds ->
                            seatIds

                        _ ->
                            []

                oldBoxOffice =
                    model.boxOffice

                newBoxOffice =
                    { oldBoxOffice | soldSeats = soldSeats }
            in
                { model | boxOffice = newBoxOffice } ! []

        SeatClicked seat ->
            if (seatIsClickable seat model.boxOffice model.session) then
                let
                    topic =
                        case model.boxOffice.selectedScreening of
                            Just screening ->
                                "screening:" ++ (toString screening.id)

                            _ ->
                                "screening:0"

                    payload =
                        JE.object [ ( "seat_id", JE.int seat.id ) ]

                    push =
                        Push.init topic "seat_status"
                            |> Push.withPayload payload
                in
                    model ! [ Phoenix.push "ws://localhost:4000/socket/websocket" push ]
            else
                model ! []

        SellTickets ->
            let
                topic =
                    case model.boxOffice.selectedScreening of
                        Just screening ->
                            "screening:" ++ (toString screening.id)

                        _ ->
                            "screening:0"

                encodedSeats =
                    model.boxOffice.lockedSeats
                        |> List.filter (\lockedSeat -> lockedSeat.userId == model.session.id)
                        |> List.map (\lockedSeat -> JE.int lockedSeat.seatId)
                        |> JE.list

                payload =
                    JE.object [ ( "seat_ids", encodedSeats ) ]

                push =
                    Push.init topic "sell_tickets"
                        |> Push.withPayload payload
            in
                model ! [ Phoenix.push "ws://localhost:4000/socket/websocket" push ]

module BoxOffice.Helpers exposing (..)

import Model exposing (Room, BoxOffice, Session, Seat, SeatList, LockedSeatList, SeatStatus(..))
import List.Extra as ListExtra


roomRowsCount : Room -> Int
roomRowsCount room =
    case room.seats of
        Just seats ->
            seats
                |> List.map (\s -> s.row)
                |> List.maximum
                |> Maybe.withDefault 0

        Nothing ->
            0


roomColumnsCount : Room -> Int
roomColumnsCount room =
    case room.seats of
        Just seats ->
            seats
                |> List.map (\s -> s.column)
                |> List.maximum
                |> Maybe.withDefault 0

        Nothing ->
            0


seatClasses : Seat -> BoxOffice -> Session -> String
seatClasses seat boxOffice session =
    let
        seats =
            boxOffice.room
                |> Maybe.andThen .seats
                |> Maybe.withDefault []

        statusClass =
            seatStatus seat boxOffice.lockedSeats session.id
                |> seatStatusClass
    in
        "seat " ++ statusClass


getSeatAt : Int -> Int -> SeatList -> Maybe Seat
getSeatAt row column seats =
    seats
        |> ListExtra.find (\s -> s.row == row && s.column == column)


seatStatus : Seat -> LockedSeatList -> Int -> SeatStatus
seatStatus seat lockedSeats userId =
    let
        findSeat =
            \lockedSeat -> lockedSeat.seatId == seat.id
    in
        case ListExtra.find findSeat lockedSeats of
            Just lockedSeat ->
                if lockedSeat.userId == userId then
                    LockedByYou
                else
                    LockedBySomeone

            _ ->
                Available


seatStatusClass : SeatStatus -> String
seatStatusClass status =
    case status of
        LockedByYou ->
            "locked-by-you"

        LockedBySomeone ->
            "locked-by-someone"

        Available ->
            "available"



-- TODO: Check if the seat is sold


seatIsClickable : Seat -> BoxOffice -> Session -> Bool
seatIsClickable seat boxOffice session =
    let
        seats =
            boxOffice.room
                |> Maybe.andThen .seats
                |> Maybe.withDefault []
    in
        case (seatStatus seat boxOffice.lockedSeats session.id) of
            Available ->
                True

            LockedByYou ->
                True

            _ ->
                False

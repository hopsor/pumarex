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
        statusClass =
            seatStatus seat boxOffice session.id
                |> seatStatusClass
    in
        "seat " ++ statusClass


getSeatAt : Int -> Int -> SeatList -> Maybe Seat
getSeatAt row column seats =
    seats
        |> ListExtra.find (\s -> s.row == row && s.column == column)


seatStatus : Seat -> BoxOffice -> Int -> SeatStatus
seatStatus seat boxOffice userId =
    let
        findSeat =
            \lockedSeat -> lockedSeat.seatId == seat.id

        isSold =
            List.member seat.id boxOffice.soldSeats
    in
        if isSold == True then
            Sold
        else
            case ListExtra.find findSeat boxOffice.lockedSeats of
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

        Sold ->
            "sold"



-- TODO: Check if the seat is sold


seatIsClickable : Seat -> BoxOffice -> Session -> Bool
seatIsClickable seat boxOffice session =
    let
        seats =
            boxOffice.room
                |> Maybe.andThen .seats
                |> Maybe.withDefault []
    in
        case (seatStatus seat boxOffice session.id) of
            Available ->
                True

            LockedByYou ->
                True

            _ ->
                False

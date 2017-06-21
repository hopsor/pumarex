module BoxOffice.Helpers exposing (..)

import Model exposing (Room, BoxOffice, Session, SeatList, LockedSeatList)
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


seatClasses : Int -> Int -> BoxOffice -> Session -> String
seatClasses row column boxOffice session =
    let
        room =
            boxOffice.room
                |> Maybe.withDefault (Room 0 "" (Just []) (Just 0))

        seats =
            room.seats
                |> Maybe.withDefault []

        kos =
            kindOfSpot row column seats
    in
        case kos of
            "seat" ->
                kos ++ " " ++ (seatStatus row column boxOffice.lockedSeats session.id)

            _ ->
                kos


kindOfSpot : Int -> Int -> SeatList -> String
kindOfSpot row column seats =
    case isSeat row column seats of
        True ->
            "seat"

        False ->
            "floor"


isSeat : Int -> Int -> SeatList -> Bool
isSeat row column seats =
    List.any (\s -> s.row == row && s.column == column) seats


seatStatus : Int -> Int -> LockedSeatList -> Int -> String
seatStatus row column lockedSeats userId =
    let
        findSeat =
            \lockedSeat -> lockedSeat.row == row && lockedSeat.column == column
    in
        case ListExtra.find findSeat lockedSeats of
            Just lockedSeat ->
                if lockedSeat.userId == userId then
                    "locked-by-you"
                else
                    "locked-by-someone"

            _ ->
                ""

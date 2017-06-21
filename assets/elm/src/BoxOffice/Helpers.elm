module BoxOffice.Helpers exposing (..)

import Model exposing (Room, BoxOffice, Session, SeatList)


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
    in
        kindOfSpot row column seats


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

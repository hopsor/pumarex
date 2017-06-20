module BoxOffice.Helpers exposing (..)

import Model exposing (Room)


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

module RoomForm.Update exposing (..)

import RoomForm.Messages exposing (..)
import Model exposing (..)
import Navigation
import Routing exposing (toPath, Route(..))
import Dict
import List.Extra exposing (getAt, updateIfIndex)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        HandleRowsChanged value ->
            let
                newRows =
                    Result.withDefault 0 (String.toInt value)

                oldRoomForm =
                    model.roomForm

                updatedRoomForm =
                    { oldRoomForm
                        | rows = newRows
                        , matrix = (recreateMatrix newRows oldRoomForm.columns)
                    }
            in
                { model | roomForm = updatedRoomForm } ! []

        HandleColumnsChanged value ->
            let
                newColumns =
                    Result.withDefault 0 (String.toInt value)

                oldRoomForm =
                    model.roomForm

                updatedRoomForm =
                    { oldRoomForm
                        | columns = newColumns
                        , matrix = (recreateMatrix oldRoomForm.rows newColumns)
                    }
            in
                { model | roomForm = updatedRoomForm } ! []

        HandleSeatSpotClick rowIndex colIndex ->
            let
                _ =
                    Debug.log "Row - Column Clicked: " ( rowIndex, colIndex )

                oldRoomForm =
                    model.roomForm

                updatedRoomForm =
                    { oldRoomForm
                        | matrix = (toggleSeat oldRoomForm.matrix rowIndex colIndex)
                    }
            in
                { model | roomForm = updatedRoomForm } ! []



-- Consider moving `recreateMatrix` function somewhere else


recreateMatrix : Int -> Int -> List (List Bool)
recreateMatrix rows columns =
    List.repeat rows (List.repeat columns False)



--- Figure out some other simpler solution to toggle matrix booleans


toggleSeat : List (List Bool) -> Int -> Int -> List (List Bool)
toggleSeat matrix rowIndex colIndex =
    case getAt rowIndex matrix of
        Nothing ->
            matrix

        Just row ->
            case getAt colIndex row of
                Nothing ->
                    matrix

                Just column ->
                    let
                        updatedRow =
                            updateIfIndex (\idx -> idx == colIndex) (\col -> not col) row
                    in
                        updateIfIndex (\idx -> idx == rowIndex) (\row -> updatedRow) matrix

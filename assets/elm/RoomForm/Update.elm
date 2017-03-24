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

        HandleNameChanged newName ->
            let
                oldRoomForm =
                    model.roomForm

                updatedRoomForm =
                    { oldRoomForm
                        | name = newName
                    }
            in
                { model | roomForm = updatedRoomForm } ! []

        HandleRowsChanged value ->
            let
                newRows =
                    Result.withDefault 0 (String.toInt value)

                oldRoomForm =
                    model.roomForm

                updatedRoomForm =
                    { oldRoomForm
                        | rows = newRows
                        , matrix = (recreateMatrix newRows oldRoomForm.columns False)
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
                        , matrix = (recreateMatrix oldRoomForm.rows newColumns False)
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

        HandleFillRowButtonClick rowIndex ->
            let
                oldRoomForm =
                    model.roomForm

                updatedRoomForm =
                    { oldRoomForm
                        | matrix = (fillMatrixRow oldRoomForm.matrix oldRoomForm.columns rowIndex)
                    }
            in
                { model | roomForm = updatedRoomForm } ! []

        HandleEmptyRowButtonClick rowIndex ->
            let
                oldRoomForm =
                    model.roomForm

                updatedRoomForm =
                    { oldRoomForm
                        | matrix = (emptyMatrixRow oldRoomForm.matrix oldRoomForm.columns rowIndex)
                    }
            in
                { model | roomForm = updatedRoomForm } ! []

        HandleFillRoomButtonClick ->
            let
                oldRoomForm =
                    model.roomForm

                updatedRoomForm =
                    { oldRoomForm
                        | matrix = (recreateMatrix oldRoomForm.rows oldRoomForm.columns True)
                    }
            in
                { model | roomForm = updatedRoomForm } ! []



-- Consider moving `recreateMatrix` function somewhere else


recreateMatrix : Int -> Int -> Bool -> List (List Bool)
recreateMatrix rows columns state =
    List.repeat rows (List.repeat columns state)



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


fillMatrixRow : List (List Bool) -> Int -> Int -> List (List Bool)
fillMatrixRow matrix colAmount rowIndex =
    let
        updatedRow =
            List.repeat colAmount True
    in
        updateIfIndex (\idx -> idx == rowIndex) (\row -> updatedRow) matrix


emptyMatrixRow : List (List Bool) -> Int -> Int -> List (List Bool)
emptyMatrixRow matrix colAmount rowIndex =
    let
        updatedRow =
            List.repeat colAmount False
    in
        updateIfIndex (\idx -> idx == rowIndex) (\row -> updatedRow) matrix

module RoomForm.Update exposing (..)

import RoomForm.Messages exposing (..)
import Model exposing (..)
import Navigation
import Routing exposing (toPath, Route(..))
import Dict


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



-- Consider moving `recreateMatrix` function somewhere else


recreateMatrix : Int -> Int -> List (List Bool)
recreateMatrix rows columns =
    List.repeat rows (List.repeat columns False)

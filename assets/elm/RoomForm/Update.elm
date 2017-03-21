module RoomForm.Update exposing (..)

import RoomForm.Messages exposing (..)


-- import RoomForm.Commands exposing (createRoom)

import Model exposing (..)
import Navigation
import Routing exposing (toPath, Route(..))
import Dict


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

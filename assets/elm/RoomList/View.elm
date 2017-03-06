module RoomList.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import RoomList.Messages exposing (..)
import Model exposing (..)


indexView : Model -> Html Msg
indexView model =
    div [ id "room_list" ]
        [ p [] [ text "Room List" ] ]

module RoomList.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import RoomList.Messages exposing (..)
import Model exposing (..)


indexView : Model -> Html Msg
indexView model =
    div [ id "room_list" ]
        [ contentView model ]


contentView : Model -> Html Msg
contentView model =
    case model.roomList of
        NotRequested ->
            p [] [ text "Rooms not loaded" ]

        Requesting ->
            div [ class "loading" ] [ text "Loading ..." ]

        Failure error ->
            div [ class "error" ] [ text error ]

        Success result ->
            roomList result


roomList : RoomList -> Html Msg
roomList resultset =
    ul []
        ((List.map roomItem resultset))


roomItem : Room -> Html Msg
roomItem room =
    li [] [ text room.name ]

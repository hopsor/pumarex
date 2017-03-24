module RoomList.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import RoomList.Messages exposing (..)
import Model exposing (..)


indexView : Model -> Html Msg
indexView model =
    div [ id "room_list" ]
        [ div
            [ class "actions" ]
            [ addItemButton ]
        , contentView model
        ]


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
            roomTable result


roomTable : RoomList -> Html Msg
roomTable resultset =
    table []
        [ thead []
            [ th [] [ text "Room Name" ]
            , th [] [ text "Capacity" ]
            ]
        , tbody [] (List.map roomTableRow resultset)
        ]


roomTableRow : Room -> Html Msg
roomTableRow room =
    tr []
        [ td [] [ text room.name ]
        , td [] [ text (toString room.capacity) ]
        ]


addItemButton : Html Msg
addItemButton =
    button
        [ onClick GoToNewRoom ]
        [ text "New Room" ]

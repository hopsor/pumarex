module RoomList.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import RoomList.Messages exposing (..)
import Model exposing (..)


indexView : Model -> Html Msg
indexView model =
    div [ id "room_list", class "portlet" ]
        [ header [] [ text "Room listing" ]
        , div
            [ class "portlet-body" ]
            [ contentView model
            , actionsView
            ]
        ]


actionsView : Html Msg
actionsView =
    div
        [ class "actions" ]
        [ addItemButton ]


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
    if not (List.isEmpty resultset) then
        table [ class "table" ]
            [ thead []
                [ th [ class "room-name" ] [ text "Room Name" ]
                , th [ class "capacity" ] [ text "Capacity" ]
                , th [] []
                ]
            , tbody [] (List.map roomTableRow resultset)
            ]
    else
        p [ class "empty" ] [ text "You haven't added any room yet." ]


roomTableRow : Room -> Html Msg
roomTableRow room =
    tr []
        [ td [] [ text room.name ]
        , td [ class "capacity" ] [ text (toString room.capacity) ]
        , td
            []
            [ button [ onClick (HandleDeleteRoomClick room) ]
                [ text "Delete" ]
            ]
        ]


addItemButton : Html Msg
addItemButton =
    button
        [ onClick GoToNewRoom ]
        [ text "New Room" ]

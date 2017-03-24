module RoomForm.View exposing (..)

import RoomForm.Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)


formView : Model -> Html Msg
formView model =
    Html.form
        [ id "room_form", class "inline" ]
        [ h1 [] [ text "Room Designer" ]
        , div
            [ class "size-manager" ]
            [ div
                [ class "field" ]
                [ label [] [ text "Rows" ]
                , input [ type_ "number", value (toString model.roomForm.rows), onInput HandleRowsChanged ] []
                ]
            , div
                [ class "field" ]
                [ label [] [ text "Columns" ]
                , input [ type_ "number", value (toString model.roomForm.columns), onInput HandleColumnsChanged ] []
                ]
            , div
                [ class "field" ]
                [ button [ type_ "button", onClick HandleFillRoomButtonClick ] [ text "Fill Room" ] ]
            ]
        , matrixView model
        ]


rowView : Int -> List Bool -> Html Msg
rowView rowIndex row =
    let
        rowColumns =
            row
                |> List.map (\spot -> ( rowIndex, spot ))
                |> List.indexedMap seatSpotView
    in
        div [ class "row" ] (rowColumns ++ rowActionsView rowIndex)


rowActionsView : Int -> List (Html Msg)
rowActionsView rowIndex =
    [ button
        [ type_ "button", class "small", onClick (HandleFillRowButtonClick rowIndex) ]
        [ text "Fill Row" ]
    , button
        [ type_ "button", class "small", onClick (HandleEmptyRowButtonClick rowIndex) ]
        [ text "Empty Row" ]
    ]


seatSpotView : Int -> ( Int, Bool ) -> Html Msg
seatSpotView colIndex ( rowIndex, spot ) =
    let
        seatClass =
            classList [ ( "seat-spot", True ), ( "has-seat", spot ) ]
    in
        div [ seatClass, onClick (HandleSeatSpotClick rowIndex colIndex) ] []


matrixView : Model -> Html Msg
matrixView model =
    let
        rows =
            model.roomForm.matrix
                |> List.indexedMap rowView
    in
        div [ class "matrix" ] (rows)

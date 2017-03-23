module RoomForm.View exposing (..)

import RoomForm.Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)


formView : Model -> Html Msg
formView model =
    Html.form
        [ id "room_form" ]
        [ div
            []
            [ input [ type_ "number", value (toString model.roomForm.rows), onInput HandleRowsChanged ] []
            , input [ type_ "number", value (toString model.roomForm.columns), onInput HandleColumnsChanged ] []
            ]
        , matrixView model
        ]


rowView : Int -> List Bool -> Html Msg
rowView rowIndex row =
    row
        |> List.map (\r -> ( rowIndex, r ))
        |> List.indexedMap seatSpotView
        |> div [ class "row" ]


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

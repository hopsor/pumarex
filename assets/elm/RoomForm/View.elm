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


rowView : List Bool -> Html Msg
rowView row =
    row
        |> List.map seatSpotView
        |> div [ class "row" ]


seatSpotView : Bool -> Html Msg
seatSpotView spot =
    div [ class "seat-spot" ] []


matrixView : Model -> Html Msg
matrixView model =
    let
        rows =
            model.roomForm.matrix
                |> List.map rowView
    in
        div [ class "matrix" ] (rows)

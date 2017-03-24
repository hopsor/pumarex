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
                , input [ type_ "number", Html.Attributes.min "0", value (toString model.roomForm.rows), onInput HandleRowsChanged ] []
                ]
            , div
                [ class "field" ]
                [ label [] [ text "Columns" ]
                , input [ type_ "number", Html.Attributes.min "0", value (toString model.roomForm.columns), onInput HandleColumnsChanged ] []
                ]
            , div
                [ class "field" ]
                [ button [ type_ "button", onClick HandleFillRoomButtonClick ] [ text "Fill Room" ] ]
            ]
        , matrixWrapperView model
        , seatsCounterView model
        ]


rowView : Int -> List Bool -> Html Msg
rowView rowIndex row =
    let
        rowCounter =
            rowCounterView (rowIndex + 1)

        rowColumns =
            row
                |> List.map (\spot -> ( rowIndex, spot ))
                |> List.indexedMap seatSpotView

        fullRow =
            [ rowCounter ] ++ rowColumns ++ rowActionsView rowIndex
    in
        div [ class "row" ] (fullRow)


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


matrixWrapperView : Model -> Html Msg
matrixWrapperView model =
    if (model.roomForm.rows > 0) && (model.roomForm.columns > 0) then
        matrixView model
    else
        div
            [ class "matrix-placeholder" ]
            [ text "Throw some rows and columns in here!" ]


matrixView : Model -> Html Msg
matrixView model =
    let
        footer =
            matrixFooterView model.roomForm.columns

        rows =
            model.roomForm.matrix
                |> List.indexedMap rowView
    in
        div [ class "matrix" ] (rows ++ [ footer ])


rowCounterView : Int -> Html Msg
rowCounterView rowNumber =
    div [ class "row-counter" ] [ text (toString rowNumber) ]


matrixFooterView : Int -> Html Msg
matrixFooterView columnCount =
    let
        footer =
            List.range 1 columnCount
                |> List.map (\colNumber -> div [ class "column-footer" ] [ text (toString colNumber) ])
    in
        div [ class "matrix-footer" ] (footer)


seatsCounterView : Model -> Html Msg
seatsCounterView model =
    let
        seatsCount =
            List.concat model.roomForm.matrix
                |> List.filter (\spot -> spot == True)
                |> List.length
    in
        div []
            [ text (toString seatsCount)
            , text "seats"
            ]

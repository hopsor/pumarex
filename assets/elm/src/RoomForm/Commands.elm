module RoomForm.Commands exposing (createRoom)

import Decoders exposing (roomDecoder)
import Json.Encode as Encode
import Model exposing (Session, RoomForm)
import Http
import RoomForm.Messages exposing (Msg(..))
import Dict
import List.Extra exposing (elemIndices)
import Helpers exposing (postRequest)


createRoom : Session -> RoomForm -> Cmd Msg
createRoom session roomForm =
    let
        body =
            encodeRoomForm roomForm
                |> Http.jsonBody

        request =
            postRequest session "/api/rooms" body roomDecoder
    in
        Http.send RoomCreated request


encodeRoomForm : RoomForm -> Encode.Value
encodeRoomForm roomForm =
    let
        encodedRoomParams =
            [ ( "name", (Encode.string roomForm.name) )
            , ( "seats", encodeSeats roomForm.matrix )
            ]

        encodedParams =
            Encode.object encodedRoomParams
    in
        Encode.object [ ( "room", encodedParams ) ]


encodeSeats : List (List Bool) -> Encode.Value
encodeSeats matrix =
    let
        encodeRow : Int -> List Bool -> List Encode.Value
        encodeRow rowIndex row =
            elemIndices True row
                |> List.map (\colIndex -> (encodeSeat (rowIndex + 1) (colIndex + 1)))

        seats =
            matrix
                |> List.indexedMap encodeRow
                |> List.concat
    in
        Encode.list seats


encodeSeat : Int -> Int -> Encode.Value
encodeSeat row column =
    [ ( "row", (Encode.int row) )
    , ( "column", (Encode.int column) )
    ]
        |> Encode.object

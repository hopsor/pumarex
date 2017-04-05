module ScreeningForm.Commands exposing (..)

import Decoders exposing (screeningDecoder, movieListDecoder, roomListDecoder)
import Json.Encode as Encode
import Model exposing (ScreeningForm)
import Http
import ScreeningForm.Messages exposing (Msg(..))
import Dict


createScreening : ScreeningForm -> Cmd Msg
createScreening screeningForm =
    let
        apiUrl =
            "/api/screenings"

        encodeTuple =
            \( key, value ) -> ( key, (Encode.string value) )

        encodedParams =
            List.map encodeTuple (Dict.toList screeningForm.fields)
                |> Encode.object

        body =
            Encode.object [ ( "screening", encodedParams ) ]
                |> Http.jsonBody

        request =
            Http.post apiUrl body screeningDecoder
    in
        Http.send ScreeningCreated request


loadScreeningForm : Cmd Msg
loadScreeningForm =
    Cmd.batch [ fetchRooms, fetchMovies ]


fetchMovies : Cmd Msg
fetchMovies =
    let
        apiUrl =
            "/api/movies"

        request =
            Http.get apiUrl movieListDecoder
    in
        Http.send FetchMovies request


fetchRooms : Cmd Msg
fetchRooms =
    let
        apiUrl =
            "/api/rooms"

        request =
            Http.get apiUrl roomListDecoder
    in
        Http.send FetchRooms request

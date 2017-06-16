module ScreeningForm.Commands exposing (..)

import Decoders exposing (screeningDecoder, movieListDecoder, roomListDecoder)
import Json.Encode as Encode
import Model exposing (Session, ScreeningForm)
import Http
import ScreeningForm.Messages exposing (Msg(..))
import Dict
import Helpers exposing (getRequest, postRequest)


createScreening : Session -> ScreeningForm -> Cmd Msg
createScreening session screeningForm =
    let
        encodeTuple =
            \( key, value ) -> ( key, (Encode.string value) )

        date =
            case Dict.get "date" screeningForm.fields of
                Nothing ->
                    ""

                Just value ->
                    value

        time =
            case Dict.get "time" screeningForm.fields of
                Nothing ->
                    ""

                Just value ->
                    value

        datetime =
            date ++ " " ++ time ++ ":00"

        encodedParams =
            screeningForm.fields
                |> Dict.remove "date"
                |> Dict.remove "time"
                |> Dict.insert "screened_at" datetime
                |> Dict.toList
                |> List.map encodeTuple
                |> Encode.object

        body =
            Encode.object [ ( "screening", encodedParams ) ]
                |> Http.jsonBody

        request =
            postRequest session "/api/screenings" body screeningDecoder
    in
        Http.send ScreeningCreated request


loadScreeningForm : Session -> Cmd Msg
loadScreeningForm session =
    Cmd.batch [ (fetchRooms session), (fetchMovies session) ]


fetchMovies : Session -> Cmd Msg
fetchMovies session =
    let
        request =
            getRequest session "/api/movies" movieListDecoder
    in
        Http.send FetchMovies request


fetchRooms : Session -> Cmd Msg
fetchRooms session =
    let
        request =
            getRequest session "/api/rooms" roomListDecoder
    in
        Http.send FetchRooms request

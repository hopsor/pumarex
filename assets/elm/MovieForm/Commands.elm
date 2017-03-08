module MovieForm.Commands exposing (..)

import Decoders exposing (movieDecoder)
import Json.Encode as Encode
import Model exposing (MovieForm)
import Http
import MovieForm.Messages exposing (Msg(..))
import Dict


createMovie : MovieForm -> Cmd Msg
createMovie movieForm =
    let
        apiUrl =
            "/api/movies"

        encodeTuple =
          \(key, value) -> (key, (Encode.string value))


        encodedParams = List.map encodeTuple (Dict.toList movieForm)
          |> Encode.object

        body = Encode.object [("movie", encodedParams)]
          |> Http.jsonBody

        request =
            Http.post apiUrl body movieDecoder
    in
        Http.send MovieCreated request

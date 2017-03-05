module MovieList.Commands exposing (..)

import Decoders exposing (movieListDecoder)
import Http
import MovieList.Messages exposing (Msg(..))


fetchMovies : Cmd Msg
fetchMovies =
    let
        apiUrl =
            "/api/movies"

        request =
            Http.get apiUrl movieListDecoder
    in
        Http.send FetchMovies request

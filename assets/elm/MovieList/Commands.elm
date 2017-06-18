module MovieList.Commands exposing (..)

import Decoders exposing (movieListDecoder)
import Http
import Helpers exposing (getRequest)
import DataModel exposing (Session)
import MovieList.Messages exposing (Msg(..))


fetchMovies : Session -> Cmd Msg
fetchMovies session =
    let
        request =
            getRequest session "/api/movies" movieListDecoder
    in
        Http.send FetchMovies request

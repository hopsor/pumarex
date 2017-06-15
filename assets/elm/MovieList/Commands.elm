module MovieList.Commands exposing (..)

import Decoders exposing (movieListDecoder)
import Http
import Model exposing (Session)
import MovieList.Messages exposing (Msg(..))


fetchMovies : Session -> Cmd Msg
fetchMovies session =
    let
        apiUrl =
            "/api/movies"

        request =
            Http.request
                { method = "GET"
                , headers = [ Http.header "Authorization" ("Bearer " ++ session.jwt) ]
                , url = apiUrl
                , body = Http.emptyBody
                , expect = Http.expectJson movieListDecoder
                , timeout = Nothing
                , withCredentials = True
                }
    in
        Http.send FetchMovies request

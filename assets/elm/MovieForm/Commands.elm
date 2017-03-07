module MovieForm.Commands exposing (..)

-- import Decoders exposing (movieListDecoder)

import Http
import MovieForm.Messages exposing (Msg(..))


createMovie : Cmd Msg
createMovie =
    let
        apiUrl =
            "/api/movies"

        request =
            Http.post apiUrl movieListDecoder
    in
        Http.send MovieCreated request

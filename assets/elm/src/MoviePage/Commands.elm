module MoviePage.Commands exposing (..)

import Decoders exposing (movieDecoder)
import Json.Encode as Encode
import Model exposing (Session)
import Http
import MoviePage.Messages exposing (Msg(..))
import Dict
import Helpers exposing (getRequest)


loadMovie : Session -> Int -> Cmd Msg
loadMovie session movieId =
    let
        request =
            getRequest session ("/api/movies/" ++ (toString movieId)) movieDecoder
    in
        Http.send LoadMovie request

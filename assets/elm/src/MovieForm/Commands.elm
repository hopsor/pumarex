module MovieForm.Commands exposing (..)

import Decoders exposing (movieDecoder)
import Json.Encode as Encode
import Model exposing (Session, MovieForm)
import Http
import MovieForm.Messages exposing (Msg(..))
import Dict
import Helpers exposing (postRequest, getRequest, putRequest)


createMovie : Session -> MovieForm -> Cmd Msg
createMovie session movieForm =
    let
        encodeTuple =
            \( key, value ) -> ( key, (Encode.string value) )

        encodedParams =
            List.map encodeTuple (Dict.toList movieForm)
                |> Encode.object

        body =
            Encode.object [ ( "movie", encodedParams ) ]
                |> Http.jsonBody

        request =
            postRequest session "/api/movies" body movieDecoder
    in
        Http.send MovieCreated request


updateMovie : Session -> String -> MovieForm -> Cmd Msg
updateMovie session movieId movieForm =
    let
        encodeTuple =
            \( key, value ) -> ( key, (Encode.string value) )

        encodedParams =
            List.map encodeTuple (Dict.toList movieForm)
                |> Encode.object

        body =
            Encode.object [ ( "movie", encodedParams ) ]
                |> Http.jsonBody

        request =
            putRequest session ("/api/movies/" ++ movieId) body movieDecoder
    in
        Http.send MovieUpdated request


fetchMovie : Session -> Int -> Cmd Msg
fetchMovie session movieId =
    let
        request =
            getRequest session ("/api/movies/" ++ (toString movieId)) movieDecoder
    in
        Http.send MovieFetched request

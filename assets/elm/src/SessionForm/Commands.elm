module SessionForm.Commands exposing (..)

import Decoders exposing (sessionDecoder)
import Json.Encode as Encode
import Model exposing (SessionForm)
import Http
import SessionForm.Messages exposing (Msg(..))


doLogin : SessionForm -> Cmd Msg
doLogin sessionForm =
    let
        apiUrl =
            "/api/sessions"

        encodedParams =
            [ ( "email", (Encode.string sessionForm.email) )
            , ( "password", (Encode.string sessionForm.password) )
            ]
                |> Encode.object

        body =
            Encode.object [ ( "user", encodedParams ) ]
                |> Http.jsonBody

        request =
            Http.post apiUrl body sessionDecoder
    in
        Http.send AuthenticationFinished request

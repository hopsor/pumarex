module ScreeningForm.Commands exposing (..)

import Decoders exposing (screeningDecoder)
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
            List.map encodeTuple (Dict.toList screeningForm)
                |> Encode.object

        body =
            Encode.object [ ( "screening", encodedParams ) ]
                |> Http.jsonBody

        request =
            Http.post apiUrl body screeningDecoder
    in
        Http.send ScreeningCreated request

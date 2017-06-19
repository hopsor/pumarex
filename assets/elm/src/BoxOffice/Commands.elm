module BoxOffice.Commands exposing (..)

import Decoders exposing (screeningListDecoder)
import Json.Encode as Encode
import Model exposing (Session)
import Http
import BoxOffice.Messages exposing (Msg(..))
import Dict
import Helpers exposing (getRequest, postRequest)


fetchAvailableScreenings : Session -> Cmd Msg
fetchAvailableScreenings session =
    let
        request =
            getRequest session "/api/screenings" screeningListDecoder
    in
        Http.send FetchScreenings request

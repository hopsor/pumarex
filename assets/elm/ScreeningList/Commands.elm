module ScreeningList.Commands exposing (..)

import Model exposing (Screening)
import Decoders exposing (screeningListDecoder)
import Http
import Json.Decode as JD
import Json.Encode as JE
import ScreeningList.Messages exposing (Msg(..))


fetchScreenings : Cmd Msg
fetchScreenings =
    let
        apiUrl =
            "/api/screenings"

        request =
            Http.get apiUrl screeningListDecoder
    in
        Http.send FetchScreenings request


deleteScreening : Screening -> Cmd Msg
deleteScreening screening =
    let
        apiUrl =
            "/api/screenings/" ++ (toString screening.id)

        request =
            Http.request
                { method = "DELETE"
                , headers = []
                , url = apiUrl
                , body = Http.emptyBody
                , expect = Http.expectString
                , timeout = Nothing
                , withCredentials = False
                }
    in
        Http.send (ScreeningDeleted screening) request

module ScreeningList.Commands exposing (..)

import Model exposing (Session, Screening)
import Decoders exposing (screeningListDecoder)
import Http
import Json.Decode as JD
import Json.Encode as JE
import ScreeningList.Messages exposing (Msg(..))
import Helpers exposing (getRequest, deleteRequest)


fetchScreenings : Session -> Cmd Msg
fetchScreenings session =
    let
        request =
            getRequest session "/api/screenings" screeningListDecoder
    in
        Http.send FetchScreenings request


deleteScreening : Session -> Screening -> Cmd Msg
deleteScreening session screening =
    let
        apiUrl =
            "/api/screenings/" ++ (toString screening.id)

        request =
            deleteRequest session apiUrl
    in
        Http.send (ScreeningDeleted screening) request

module Helpers exposing (..)

import Model exposing (Session)
import Navigation
import Routing exposing (parseLocation, Route(..))
import Http
import Json.Decode as Json


getRoute : Bool -> Navigation.Location -> Route
getRoute loggedIn location =
    case loggedIn of
        True ->
            parseLocation location

        False ->
            NewSessionRoute


getRequest : Session -> String -> Json.Decoder a -> Http.Request a
getRequest session url decoder =
    Http.request
        { method = "GET"
        , headers = [ Http.header "Authorization" ("Bearer " ++ session.jwt) ]
        , url = url
        , body = Http.emptyBody
        , expect = Http.expectJson decoder
        , timeout = Nothing
        , withCredentials = True
        }


deleteRequest : Session -> String -> Http.Request String
deleteRequest session url =
    Http.request
        { method = "DELETE"
        , headers = [ Http.header "Authorization" ("Bearer " ++ session.jwt) ]
        , url = url
        , body = Http.emptyBody
        , expect = Http.expectString
        , timeout = Nothing
        , withCredentials = True
        }

module Helpers exposing (..)

import Model exposing (Session)
import Navigation
import Routing exposing (parseLocation, Route(..))


getRoute : Maybe Session -> Navigation.Location -> Route
getRoute session location =
    case session of
        Just session ->
            parseLocation location

        Nothing ->
            NewSessionRoute

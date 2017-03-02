module Routing exposing (..)

import Navigation
import UrlParser exposing (..)


type Route
    = RootRoute
    | MoviesRoute
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map RootRoute <| s ""
        , map MoviesRoute <| s "movies" ]

parseLocation : Navigation.Location -> Route
parseLocation location =
    case UrlParser.parsePath matchers location of
        Just route ->
            route

        Nothing ->
            NotFoundRoute

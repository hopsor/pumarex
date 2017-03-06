module Routing exposing (..)

import Navigation
import UrlParser exposing (..)


type Route
    = RootRoute
    | MoviesRoute
    | RoomsRoute
    | NotFoundRoute


toPath : Route -> String
toPath route =
    case route of
        RootRoute ->
            "/"

        MoviesRoute ->
            "/movies"

        RoomsRoute ->
            "/rooms"

        NotFoundRoute ->
            "/not-found"


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map RootRoute <| s ""
        , map MoviesRoute <| s "movies"
        , map RoomsRoute <| s "rooms"
        ]


parseLocation : Navigation.Location -> Route
parseLocation location =
    case UrlParser.parsePath matchers location of
        Just route ->
            route

        Nothing ->
            NotFoundRoute

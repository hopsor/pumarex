module Routing exposing (..)

import Navigation
import UrlParser exposing (..)


type Route
    = RootRoute
    | NewMovieRoute
    | MoviesRoute
    | NewRoomRoute
    | RoomsRoute
    | ScreeningsRoute
    | NotFoundRoute


toPath : Route -> String
toPath route =
    case route of
        RootRoute ->
            "/"

        NewMovieRoute ->
            "/movies/new"

        MoviesRoute ->
            "/movies"

        NewRoomRoute ->
            "/rooms/new"

        RoomsRoute ->
            "/rooms"

        ScreeningsRoute ->
            "/screenings"

        NotFoundRoute ->
            "/not-found"


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map RootRoute <| s ""
        , map NewMovieRoute <| s "movies" </> s "new"
        , map MoviesRoute <| s "movies"
        , map NewRoomRoute <| s "rooms" </> s "new"
        , map RoomsRoute <| s "rooms"
        , map ScreeningsRoute <| s "screenings"
        ]


parseLocation : Navigation.Location -> Route
parseLocation location =
    case UrlParser.parsePath matchers location of
        Just route ->
            route

        Nothing ->
            NotFoundRoute

module Routing exposing (..)

import Navigation
import UrlParser exposing (..)
import Html exposing (Attribute)
import Html.Events exposing (onWithOptions, defaultOptions)
import Json.Decode as JD


type Route
    = RootRoute
    | NewMovieRoute
    | MovieRoute Int
    | EditMovieRoute Int
    | MoviesRoute
    | NewRoomRoute
    | RoomsRoute
    | NewScreeningRoute
    | ScreeningsRoute
    | NewSessionRoute
    | BoxOfficeRoute
    | NotFoundRoute


toPath : Route -> String
toPath route =
    case route of
        RootRoute ->
            "/"

        NewMovieRoute ->
            "/movies/new"

        MovieRoute movieId ->
            "/movies/" ++ (toString movieId)

        EditMovieRoute movieId ->
            "/movies/" ++ (toString movieId) ++ "/edit"

        MoviesRoute ->
            "/movies"

        NewRoomRoute ->
            "/rooms/new"

        RoomsRoute ->
            "/rooms"

        NewScreeningRoute ->
            "/screenings/new"

        ScreeningsRoute ->
            "/screenings"

        NewSessionRoute ->
            "/sessions/new"

        BoxOfficeRoute ->
            "/box-office"

        NotFoundRoute ->
            "/not-found"


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map RootRoute <| s ""
        , map NewMovieRoute <| s "movies" </> s "new"
        , map MovieRoute <| s "movies" </> int
        , map EditMovieRoute <| s "movies" </> int </> s "edit"
        , map MoviesRoute <| s "movies"
        , map NewRoomRoute <| s "rooms" </> s "new"
        , map RoomsRoute <| s "rooms"
        , map NewScreeningRoute <| s "screenings" </> s "new"
        , map ScreeningsRoute <| s "screenings"
        , map NewSessionRoute <| s "sessions" </> s "new"
        , map BoxOfficeRoute <| s "box-office"
        ]


parseLocation : Navigation.Location -> Route
parseLocation location =
    case UrlParser.parsePath matchers location of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


onPreventDefaultClick : a -> Attribute a
onPreventDefaultClick message =
    onWithOptions
        "click"
        { defaultOptions | preventDefault = True }
        (JD.succeed message)

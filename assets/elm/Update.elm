module Update exposing (..)

import Messages exposing (Msg(..))
import Model exposing (..)
import Routing exposing (parseLocation, Route(..))
import Home.Update
import SideNav.Update
import MovieList.Update
import MovieList.Commands exposing (fetchMovies)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                urlUpdate newRoute (initialModel newRoute)

        HomeMsg subMsg ->
            let
                ( newModel, cmd ) =
                    Home.Update.update subMsg model
            in
                ( newModel
                , Cmd.map HomeMsg cmd
                )

        SideNavMsg subMsg ->
            let
                ( newModel, cmd ) =
                    SideNav.Update.update subMsg model
            in
                ( newModel
                , Cmd.map SideNavMsg cmd
                )

        MovieListMsg subMsg ->
            let
                ( newModel, cmd ) =
                    MovieList.Update.update subMsg model
            in
                ( newModel
                , Cmd.map MovieListMsg cmd
                )


urlUpdate : Route -> Model -> ( Model, Cmd Msg )
urlUpdate currentRoute model =
    case currentRoute of
        MoviesRoute ->
            ( { model | route = currentRoute, movieList = Requesting }
            , Cmd.map MovieListMsg (fetchMovies)
            )

        _ ->
            { model | route = currentRoute } ! []

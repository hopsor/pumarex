module Update exposing (..)

import Messages exposing (Msg(..))
import Model exposing (..)
import Routing exposing (Route(..))
import Helpers exposing (getRoute)
import Home.Update
import SideNav.Update
import MovieForm.Update
import MoviePage.Update
import MovieList.Update
import RoomForm.Update
import RoomList.Update
import ScreeningForm.Update
import ScreeningList.Update
import SessionForm.Update
import BoxOffice.Update
import MoviePage.Commands exposing (loadMovie)
import MovieForm.Commands exposing (fetchMovie)
import MovieList.Commands exposing (fetchMovies)
import RoomList.Commands exposing (fetchRooms)
import ScreeningList.Commands exposing (fetchScreenings)
import ScreeningForm.Commands exposing (loadScreeningForm)
import BoxOffice.Commands exposing (fetchAvailableScreenings)
import Navigation
import Routing exposing (toPath, Route(..))
import Ports exposing (destroySessionData)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnLocationChange location ->
            let
                newRoute =
                    getRoute model.loggedIn location
            in
                urlUpdate newRoute (initialModel model.loggedIn model.session model.websocketUrl newRoute)

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

        MovieFormMsg subMsg ->
            let
                ( newModel, cmd ) =
                    MovieForm.Update.update subMsg model
            in
                ( newModel
                , Cmd.map MovieFormMsg cmd
                )

        MoviePageMsg subMsg ->
            let
                ( newModel, cmd ) =
                    MoviePage.Update.update subMsg model
            in
                ( newModel
                , Cmd.map MoviePageMsg cmd
                )

        MovieListMsg subMsg ->
            let
                ( newModel, cmd ) =
                    MovieList.Update.update subMsg model
            in
                ( newModel
                , Cmd.map MovieListMsg cmd
                )

        RoomFormMsg subMsg ->
            let
                ( newModel, cmd ) =
                    RoomForm.Update.update subMsg model
            in
                ( newModel
                , Cmd.map RoomFormMsg cmd
                )

        RoomListMsg subMsg ->
            let
                ( newModel, cmd ) =
                    RoomList.Update.update subMsg model
            in
                ( newModel
                , Cmd.map RoomListMsg cmd
                )

        ScreeningFormMsg subMsg ->
            let
                ( newModel, cmd ) =
                    ScreeningForm.Update.update subMsg model
            in
                ( newModel
                , Cmd.map ScreeningFormMsg cmd
                )

        ScreeningListMsg subMsg ->
            let
                ( newModel, cmd ) =
                    ScreeningList.Update.update subMsg model
            in
                ( newModel
                , Cmd.map ScreeningListMsg cmd
                )

        SessionFormMsg subMsg ->
            let
                ( newModel, cmd ) =
                    SessionForm.Update.update subMsg model
            in
                ( newModel
                , Cmd.map SessionFormMsg cmd
                )

        BoxOfficeMsg subMsg ->
            let
                ( newModel, cmd ) =
                    BoxOffice.Update.update subMsg model
            in
                ( newModel
                , Cmd.map BoxOfficeMsg cmd
                )

        Logout ->
            { model | session = emptySession, loggedIn = False } ! [ destroySessionData (), Navigation.newUrl (toPath NewSessionRoute) ]


urlUpdate : Route -> Model -> ( Model, Cmd Msg )
urlUpdate currentRoute model =
    case currentRoute of
        MovieRoute movieId ->
            ( { model | route = currentRoute, movie = Requesting }
            , Cmd.map MoviePageMsg (loadMovie model.session movieId)
            )

        EditMovieRoute movieId ->
            ( { model | route = currentRoute }
            , Cmd.map MovieFormMsg (fetchMovie model.session movieId)
            )

        MoviesRoute ->
            ( { model | route = currentRoute, movieList = Requesting }
            , Cmd.map MovieListMsg (fetchMovies model.session)
            )

        RoomsRoute ->
            ( { model | route = currentRoute, roomList = Requesting }
            , Cmd.map RoomListMsg (fetchRooms model.session)
            )

        ScreeningsRoute ->
            ( { model | route = currentRoute, screeningList = Requesting }
            , Cmd.map ScreeningListMsg (fetchScreenings model.session)
            )

        NewScreeningRoute ->
            ( { model | route = currentRoute }
            , Cmd.map ScreeningFormMsg (loadScreeningForm model.session)
            )

        BoxOfficeRoute ->
            ( { model | route = currentRoute }
            , Cmd.map BoxOfficeMsg (fetchAvailableScreenings model.session)
            )

        _ ->
            { model | route = currentRoute } ! []

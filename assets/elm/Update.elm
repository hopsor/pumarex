module Update exposing (..)

import Messages exposing (Msg(..))
import Model exposing (..)
import Routing exposing (parseLocation, Route(..))
import Home.Update
import SideNav.Update
import MovieForm.Update
import MovieList.Update
import RoomForm.Update
import RoomList.Update
import ScreeningForm.Update
import ScreeningList.Update
import SessionForm.Update
import MovieList.Commands exposing (fetchMovies)
import RoomList.Commands exposing (fetchRooms)
import ScreeningList.Commands exposing (fetchScreenings)
import ScreeningForm.Commands exposing (loadScreeningForm)


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

        MovieFormMsg subMsg ->
            let
                ( newModel, cmd ) =
                    MovieForm.Update.update subMsg model
            in
                ( newModel
                , Cmd.map MovieFormMsg cmd
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


urlUpdate : Route -> Model -> ( Model, Cmd Msg )
urlUpdate currentRoute model =
    case currentRoute of
        MoviesRoute ->
            ( { model | route = currentRoute, movieList = Requesting }
            , Cmd.map MovieListMsg (fetchMovies)
            )

        RoomsRoute ->
            ( { model | route = currentRoute, roomList = Requesting }
            , Cmd.map RoomListMsg (fetchRooms)
            )

        ScreeningsRoute ->
            ( { model | route = currentRoute, screeningList = Requesting }
            , Cmd.map ScreeningListMsg (fetchScreenings)
            )

        NewScreeningRoute ->
            ( { model | route = currentRoute }
            , Cmd.map ScreeningFormMsg (loadScreeningForm)
            )

        _ ->
            { model | route = currentRoute } ! []

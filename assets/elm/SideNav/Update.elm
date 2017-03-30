module SideNav.Update exposing (..)

import SideNav.Messages exposing (..)
import Model exposing (..)
import Navigation
import Routing exposing (toPath, Route(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        GoToMovies ->
            model ! [ Navigation.newUrl (toPath MoviesRoute) ]

        GoToRooms ->
            model ! [ Navigation.newUrl (toPath RoomsRoute) ]

        GoToScreenings ->
            model ! [ Navigation.newUrl (toPath ScreeningsRoute) ]

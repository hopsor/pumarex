module MovieList.Update exposing (..)

import MovieList.Messages exposing (..)
import Model exposing (..)
import Navigation
import Routing exposing (toPath, Route(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        FetchMovies (Ok response) ->
            { model | movieList = Success response } ! []

        FetchMovies (Err error) ->
            { model | movieList = Failure "Something went wrong..." } ! []

        GoToNewMovie ->
            model ! [ Navigation.newUrl (toPath NewMovieRoute) ]

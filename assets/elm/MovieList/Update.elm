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
        ShowMovies ->
            ( model, Navigation.newUrl (toPath MoviesRoute))

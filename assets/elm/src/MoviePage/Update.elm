module MoviePage.Update exposing (..)

import MoviePage.Messages exposing (..)
import Model exposing (..)
import Navigation
import Routing exposing (toPath, Route(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        LoadMovie (Ok response) ->
            { model | movie = Success response } ! []

        LoadMovie (Err error) ->
            { model | movie = Failure "Something went wrong..." } ! []

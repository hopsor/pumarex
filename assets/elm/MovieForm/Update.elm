module MovieForm.Update exposing (..)

import MovieForm.Messages exposing (..)
import MovieForm.Commands exposing (createMovie)
import Model exposing (..)
import Navigation
import Routing exposing (toPath, Route(..))
import Dict


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        FieldChange field value ->
            let
                updatedMovieForm =
                    Dict.insert field value model.movieForm
            in
                { model | movieForm = updatedMovieForm } ! []

        MovieCreated (Ok response) ->
            model ! [ Navigation.newUrl (toPath MoviesRoute) ]

        MovieCreated (Err error) ->
            model ! []

        Save ->
            model ! [ createMovie model.session model.movieForm ]

module MovieForm.Update exposing (..)

import MovieForm.Messages exposing (..)
import Model exposing (..)
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
            model ! []

        MovieCreated (Err error) ->
            model ! []

        Save ->
            model ! []

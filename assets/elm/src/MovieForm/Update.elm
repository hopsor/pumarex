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

        MovieFetched (Ok movie) ->
            let
                updatedMovieForm =
                    model.movieForm
                        |> Dict.insert "id" (toString movie.id)
                        |> Dict.insert "title" movie.title
                        |> Dict.insert "director" movie.director
                        |> Dict.insert "cast" movie.cast
                        |> Dict.insert "poster" movie.poster
                        |> Dict.insert "overview" movie.overview
                        |> Dict.insert "year" (toString movie.year)
                        |> Dict.insert "duration" (toString movie.duration)
            in
                { model | movieForm = updatedMovieForm } ! []

        MovieFetched (Err error) ->
            model ! []

        Save ->
            model ! [ createMovie model.session model.movieForm ]

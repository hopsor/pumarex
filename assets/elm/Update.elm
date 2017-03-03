module Update exposing (..)

import Messages exposing (Msg(..))
import Model exposing (Model)
import Routing exposing (parseLocation)
import Home.Update
import MovieList.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )

        HomeMsg subMsg ->
            let
                ( newModel, cmd ) =
                    Home.Update.update subMsg model
            in
                ( newModel
                , Cmd.map HomeMsg cmd
                )

        MovieListMsg subMsg ->
            let
                ( newModel, cmd ) =
                    MovieList.Update.update subMsg model
            in
                ( newModel
                , Cmd.map MovieListMsg cmd
                )

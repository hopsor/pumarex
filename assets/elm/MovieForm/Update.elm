module MovieForm.Update exposing (..)

import MovieForm.Messages exposing (..)
import Model exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        Title title ->
            --- { model | movie = { model.movie | title = title } }
            model ! []

        Year year ->
            -- { model | movie = { movie | year = year } }
            model ! []

        Duration duration ->
            -- { model | movie = { movie | duration = duration } }
            model ! []

        Director director ->
            -- { model | movie = { movie | director = director } }
            model ! []

        Cast cast ->
            -- { model | movie = { movie | cast = cast } }
            model ! []

        Overview overview ->
            -- { model | movie = { movie | overview = overview } }
            model ! []

        Poster poster ->
            -- { model | movie = { movie | poster = poster } }
            model ! []

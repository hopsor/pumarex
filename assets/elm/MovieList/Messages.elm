module MovieList.Messages exposing (..)

import Http
import Model exposing (MovieList)


type Msg
    = NoOp
    | FetchMovies (Result Http.Error MovieList)
    | GoToNewMovie

module MovieList.Messages exposing (..)

import Http
import DataModel exposing (MovieList)


type Msg
    = NoOp
    | FetchMovies (Result Http.Error MovieList)
    | GoToNewMovie

module Types exposing (..)


import Home.Types exposing (..)
import MovieList.Types exposing (..)
import Navigation exposing (Location)

type Msg
    = OnLocationChange Location
    | HomeMsg Home.Types.Msg
    | MovieListMsg MovieList.Types.Msg

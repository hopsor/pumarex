module Messages exposing (..)


import Home.Messages exposing (..)
import MovieList.Messages exposing (..)
import Navigation exposing (Location)

type Msg
    = OnLocationChange Location
    | HomeMsg Home.Messages.Msg
    | MovieListMsg MovieList.Messages.Msg

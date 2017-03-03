module Model exposing (..)

import Routing exposing (Route)

type alias Model =
    { movieList : MovieList
    , route : Route
    }


type alias MovieList =
    { entries : List Movie
    , page_number : Int
    , total_entries : Int
    , total_pages : Int
    }


type alias Movie =
    { id : Int
    , title : String
    , year : Int
    , duration : Int
    , director : String
    , cast : String
    , overview : String
    , poster : String
    }


initialMovieList : MovieList
initialMovieList =
    { entries = []
    , page_number = 1
    , total_entries = 0
    , total_pages = 0
    }


initialModel : Routing.Route -> Model
initialModel route =
    { movieList = initialMovieList
    , route = route
    }

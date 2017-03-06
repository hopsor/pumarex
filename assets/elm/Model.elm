module Model exposing (..)

import Routing exposing (Route)


type RemoteData e a
    = NotRequested
    | Requesting
    | Failure e
    | Success a


type alias Model =
    { movieList : RemoteData String MovieList
    , movie : Movie
    , route : Route
    }


type alias MovieList =
    { entries : List Movie
    , page_number : Int
    , total_entries : Int
    , total_pages : Int
    }


type alias Movie =
    { id : Maybe Int
    , title : String
    , year : Maybe Int
    , duration : Maybe Int
    , director : String
    , cast : String
    , overview : String
    , poster : String
    }


initialModel : Routing.Route -> Model
initialModel route =
    { movieList = NotRequested
    , movie = Movie Nothing "" Nothing Nothing "" "" "" ""
    , route = route
    }

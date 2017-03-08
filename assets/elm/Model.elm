module Model exposing (..)

import Routing exposing (Route)
import Dict exposing (Dict)


type RemoteData e a
    = NotRequested
    | Requesting
    | Failure e
    | Success a


type alias Model =
    { movieList : RemoteData String MovieList
    , movieForm : MovieForm
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

type alias MovieForm =
  Dict String String


initialModel : Routing.Route -> Model
initialModel route =
    { movieList = NotRequested
    , movieForm = Dict.empty
    , route = route
    }

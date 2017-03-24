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
    , roomList : RemoteData String RoomList
    , roomForm : RoomForm
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


type alias RoomList =
    List Room


type alias Room =
    { id : Int
    , name : String
    , seats : Maybe SeatList
    }


type alias RoomForm =
    { name : String
    , rows : Int
    , columns : Int
    , matrix : List (List Bool)
    }


type alias Seat =
    { id : Int
    , row : Int
    , column : Int
    }


type alias SeatList =
    List Seat


initialModel : Routing.Route -> Model
initialModel route =
    { movieList = NotRequested
    , movieForm = Dict.empty
    , roomList = NotRequested
    , roomForm = { name = "", rows = 0, columns = 0, matrix = [] }
    , route = route
    }

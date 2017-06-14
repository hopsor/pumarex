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
    , screeningList : RemoteData String ScreeningList
    , screeningForm : ScreeningForm
    , sessionForm : SessionForm
    , session : Maybe Session
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
    , capacity : Maybe Int
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


type alias Screening =
    { id : Int
    , screenedAt : String
    , movie : Movie
    , room : Room
    }


type alias ScreeningForm =
    { fields : Dict String String
    , movies : RemoteData String MovieList
    , rooms : RemoteData String RoomList
    }


type alias ScreeningList =
    List Screening


type alias Session =
    { id : Int
    , email : String
    , firstName : String
    , lastName : String
    , jwt : String
    , exp : Int
    }


type alias SessionForm =
    { email : String
    , password : String
    }


type alias Flags =
    { sessionData : Maybe Session
    }


initialModel : Maybe Session -> Routing.Route -> Model
initialModel session route =
    { movieList = NotRequested
    , movieForm = Dict.empty
    , roomList = NotRequested
    , roomForm = { name = "", rows = 0, columns = 0, matrix = [] }
    , screeningList = NotRequested
    , screeningForm = { fields = Dict.empty, movies = NotRequested, rooms = NotRequested }
    , sessionForm = { email = "", password = "" }
    , session = session
    , route = route
    }

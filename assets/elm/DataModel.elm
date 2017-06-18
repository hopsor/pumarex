module DataModel exposing (..)

import Dict exposing (Dict)


type RemoteData e a
    = NotRequested
    | Requesting
    | Failure e
    | Success a


type alias MovieForm =
    Dict String String


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


type alias MovieList =
    { entries : List Movie
    , page_number : Int
    , total_entries : Int
    , total_pages : Int
    }


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


type alias BoxOffice =
    { availableScreenings : RemoteData String ScreeningList
    , selectedScreening : Maybe Screening
    }


type alias Session =
    { id : Int
    , email : String
    , firstName : String
    , lastName : String
    , jwt : String
    , exp : Int
    , avatarUrl : String
    }


type alias SessionForm =
    { email : String
    , password : String
    }


emptySession : Session
emptySession =
    { id = 0, email = "", firstName = "", lastName = "", jwt = "", exp = 0, avatarUrl = "" }

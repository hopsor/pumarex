module Model exposing (..)

import Routing exposing (Route)
import Dict exposing (Dict)
import Phoenix.Socket
import Messages exposing (Msg(..))
import DataModel exposing (..)


type alias Model =
    { movieList : RemoteData String MovieList
    , movieForm : MovieForm
    , roomList : RemoteData String RoomList
    , roomForm : RoomForm
    , screeningList : RemoteData String ScreeningList
    , screeningForm : ScreeningForm
    , boxOffice : BoxOffice
    , sessionForm : SessionForm
    , session : Session
    , loggedIn : Bool
    , route : Route
    , phxSocket : Phoenix.Socket.Socket Msg
    }


type alias Flags =
    { sessionData : Maybe Session
    , loggedIn : Bool
    }


initialModel : Bool -> Session -> Routing.Route -> Model
initialModel loggedIn session route =
    { movieList = NotRequested
    , movieForm = Dict.empty
    , roomList = NotRequested
    , roomForm = { name = "", rows = 0, columns = 0, matrix = [] }
    , screeningList = NotRequested
    , screeningForm = { fields = Dict.empty, movies = NotRequested, rooms = NotRequested }
    , boxOffice = { availableScreenings = NotRequested, selectedScreening = Nothing }
    , sessionForm = { email = "", password = "" }
    , session = session
    , loggedIn = loggedIn
    , route = route
    , phxSocket = initPhxSocket
    }


initPhxSocket : Phoenix.Socket.Socket Msg
initPhxSocket =
    Phoenix.Socket.init "ws://localhost:4000/ws"
        |> Phoenix.Socket.withDebug

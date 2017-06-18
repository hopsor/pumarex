module ScreeningForm.Messages exposing (..)

import Http
import DataModel exposing (Screening, RoomList, MovieList)


type Msg
    = NoOp
    | FieldChange String String
    | ScreeningCreated (Result Http.Error Screening)
    | FetchRooms (Result Http.Error RoomList)
    | FetchMovies (Result Http.Error MovieList)
    | Save

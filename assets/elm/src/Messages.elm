module Messages exposing (..)

import Home.Messages exposing (..)
import SideNav.Messages exposing (..)
import MovieForm.Messages exposing (..)
import MoviePage.Messages exposing (..)
import MovieList.Messages exposing (..)
import RoomForm.Messages exposing (..)
import RoomList.Messages exposing (..)
import ScreeningForm.Messages exposing (..)
import ScreeningList.Messages exposing (..)
import SessionForm.Messages exposing (..)
import BoxOffice.Messages exposing (..)
import Navigation exposing (Location)


type Msg
    = OnLocationChange Location
    | HomeMsg Home.Messages.Msg
    | SideNavMsg SideNav.Messages.Msg
    | MoviePageMsg MoviePage.Messages.Msg
    | MovieFormMsg MovieForm.Messages.Msg
    | MovieListMsg MovieList.Messages.Msg
    | RoomFormMsg RoomForm.Messages.Msg
    | RoomListMsg RoomList.Messages.Msg
    | ScreeningFormMsg ScreeningForm.Messages.Msg
    | ScreeningListMsg ScreeningList.Messages.Msg
    | SessionFormMsg SessionForm.Messages.Msg
    | BoxOfficeMsg BoxOffice.Messages.Msg
    | Logout

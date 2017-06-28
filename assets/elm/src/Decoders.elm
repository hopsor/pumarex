module Decoders exposing (..)

import Json.Decode as JD exposing (..)
import Json.Decode.Extra exposing ((|:))
import Model exposing (..)


type alias MovieResponse =
    { movie : Maybe Movie
    , error : Maybe String
    }


movieListDecoder : JD.Decoder MovieList
movieListDecoder =
    succeed
        MovieList
        |: (field "entries" (list movieDecoder))
        |: (field "page_number" int)
        |: (field "total_entries" int)
        |: (field "total_pages" int)


movieDecoder : JD.Decoder Movie
movieDecoder =
    succeed
        Movie
        |: (field "id" int)
        |: (field "title" string)
        |: (field "year" int)
        |: (field "duration" int)
        |: (field "director" string)
        |: (field "cast" string)
        |: (field "overview" string)
        |: (field "poster" string)


roomListDecoder : JD.Decoder RoomList
roomListDecoder =
    list roomDecoder


roomDecoder : JD.Decoder Room
roomDecoder =
    succeed
        Room
        |: (field "id" int)
        |: (field "name" string)
        |: (maybe (field "seats" (list seatDecoder)))
        |: (maybe (field "capacity" int))


seatDecoder : JD.Decoder Seat
seatDecoder =
    succeed
        Seat
        |: (field "id" int)
        |: (field "row" int)
        |: (field "column" int)


screeningListDecoder : JD.Decoder ScreeningList
screeningListDecoder =
    list screeningDecoder


screeningDecoder : JD.Decoder Screening
screeningDecoder =
    succeed
        Screening
        |: (field "id" int)
        |: (field "screened_at" string)
        |: (field "movie" movieDecoder)
        |: (field "room" roomDecoder)
        |: (field "name" string)


sessionDecoder : JD.Decoder Session
sessionDecoder =
    succeed
        Session
        |: (field "id" int)
        |: (field "email" string)
        |: (field "first_name" string)
        |: (field "last_name" string)
        |: (field "jwt" string)
        |: (field "exp" int)
        |: (field "avatar_url" string)


ticketSellerDecoder : JD.Decoder TicketSeller
ticketSellerDecoder =
    succeed
        TicketSeller
        |: (field "id" int)
        |: (field "full_name" string)
        |: (field "avatar" string)
        |: (field "phx_ref" string)


lockedSeatDecoder : JD.Decoder LockedSeat
lockedSeatDecoder =
    succeed
        LockedSeat
        |: (field "seat_id" int)
        |: (field "user_id" int)


lockedSeatListDecoder : JD.Decoder LockedSeatList
lockedSeatListDecoder =
    list lockedSeatDecoder

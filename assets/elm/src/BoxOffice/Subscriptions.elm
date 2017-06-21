module BoxOffice.Subscriptions exposing (..)

import Model exposing (..)
import BoxOffice.Messages exposing (Msg(..))
import Phoenix
import Phoenix.Socket as Socket exposing (Socket)
import Phoenix.Presence as Presence exposing (Presence)
import Phoenix.Channel as Channel


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.boxOffice.selectedScreening of
        Just screening ->
            let
                channelName =
                    "screening:" ++ (toString screening.id)

                presence =
                    Presence.create
                        |> Presence.onChange UpdatePresence

                channel =
                    Channel.init channelName
                        |> Channel.on "room_loaded" (\msg -> RoomLoaded msg)
                        |> Channel.on "locked_seats" (\msg -> LockedSeats msg)
                        |> Channel.withPresence presence
                        |> Channel.withDebug

                socketSub =
                    Phoenix.connect (getSocket model) [ channel ]
            in
                Sub.batch [ socketSub ]

        Nothing ->
            let
                socketSub =
                    Phoenix.connect (getSocket model) []
            in
                Sub.batch [ socketSub ]


getSocket : Model -> Socket Msg
getSocket model =
    Socket.init "ws://localhost:4000/socket/websocket"
        |> Socket.withParams [ ( "guardian_token", model.session.jwt ) ]

module Subscriptions exposing (..)

import Model exposing (..)
import Messages exposing (Msg(..))
import Phoenix
import Phoenix.Socket as Socket
import Phoenix.Channel as Channel


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.boxOffice.selectedScreening of
        Just screening ->
            let
                socket =
                    Socket.init "ws://localhost:4000/socket/websocket"
                        |> Socket.withParams [ ( "guardian_token", model.session.jwt ) ]

                channelName =
                    "screening:" ++ (toString screening.id)

                channel =
                    Channel.init channelName
                        |> Channel.withDebug

                socketSub =
                    Phoenix.connect socket [ channel ]
            in
                Sub.batch [ socketSub ]

        _ ->
            Sub.none

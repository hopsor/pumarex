module Subscriptions exposing (..)

import Model exposing (..)
import Messages exposing (Msg(..))
import Phoenix.Socket


subscriptions : Model -> Sub Msg
subscriptions model =
    Phoenix.Socket.listen model.phxSocket PhoenixMsg

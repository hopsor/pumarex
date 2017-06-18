module Subscriptions exposing (..)

import Model exposing (..)
import Messages exposing (Msg(..))
import BoxOffice.Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map BoxOfficeMsg (BoxOffice.Subscriptions.subscriptions model)

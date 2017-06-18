port module Ports exposing (..)

import DataModel exposing (Session)


-- In Ports
-- Out Ports


port storeSessionData : Session -> Cmd msg


port destroySessionData : () -> Cmd msg

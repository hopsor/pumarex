port module Ports exposing (..)

import Model exposing (Session)


-- In Ports
-- Out Ports


port storeSessionData : Session -> Cmd msg

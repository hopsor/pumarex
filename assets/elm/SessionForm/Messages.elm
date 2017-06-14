module SessionForm.Messages exposing (..)

import Http
import Model exposing (Session)


type Msg
    = NoOp
    | EmailUpdated String
    | PasswordUpdated String
    | Authenticate
    | AuthenticationFinished (Result Http.Error Session)

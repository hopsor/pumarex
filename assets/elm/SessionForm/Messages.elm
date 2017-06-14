module SessionForm.Messages exposing (..)


type Msg
    = NoOp
    | EmailUpdated String
    | PasswordUpdated String
    | Authenticate

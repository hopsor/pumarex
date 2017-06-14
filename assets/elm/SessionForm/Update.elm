module SessionForm.Update exposing (..)

import SessionForm.Messages exposing (..)
import Model exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        EmailUpdated email ->
            let
                oldSessionForm =
                    model.sessionForm

                updatedSessionForm =
                    { oldSessionForm | email = email }
            in
                { model | sessionForm = updatedSessionForm } ! []

        PasswordUpdated password ->
            let
                oldSessionForm =
                    model.sessionForm

                updatedSessionForm =
                    { oldSessionForm | password = password }
            in
                { model | sessionForm = updatedSessionForm } ! []

        Authenticate ->
            model ! []

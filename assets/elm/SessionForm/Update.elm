module SessionForm.Update exposing (..)

import SessionForm.Messages exposing (..)
import SessionForm.Commands exposing (doLogin)
import Model exposing (..)
import Navigation
import Routing exposing (toPath, Route(..))
import Ports exposing (storeSessionData)


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
            model ! [ doLogin model.sessionForm ]

        AuthenticationFinished (Ok response) ->
            model ! [ storeSessionData response, Navigation.newUrl (toPath RootRoute) ]

        AuthenticationFinished (Err error) ->
            model ! []

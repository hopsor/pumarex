module ScreeningForm.Update exposing (..)

import ScreeningForm.Messages exposing (..)
import ScreeningForm.Commands exposing (createScreening)
import Model exposing (..)
import Navigation
import Routing exposing (toPath, Route(..))
import Dict


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        FieldChange field value ->
            let
                updatedScreeningForm =
                    Dict.insert field value model.screeningForm
            in
                { model | screeningForm = updatedScreeningForm } ! []

        ScreeningCreated (Ok response) ->
            model ! [ Navigation.newUrl (toPath ScreeningsRoute) ]

        ScreeningCreated (Err error) ->
            model ! []

        Save ->
            model ! [ createScreening model.screeningForm ]

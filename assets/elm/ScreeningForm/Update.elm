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
                oldScreeningForm =
                    model.screeningForm

                updatedFormFields =
                    Dict.insert field value model.screeningForm.fields

                updatedScreeningForm =
                    { oldScreeningForm | fields = updatedFormFields }
            in
                { model | screeningForm = updatedScreeningForm } ! []

        ScreeningCreated (Ok response) ->
            model ! [ Navigation.newUrl (toPath ScreeningsRoute) ]

        ScreeningCreated (Err error) ->
            model ! []

        FetchRooms (Ok response) ->
            let
                oldScreeningForm =
                    model.screeningForm

                updatedScreeningForm =
                    { oldScreeningForm | rooms = Success response }
            in
                { model | screeningForm = updatedScreeningForm } ! []

        FetchRooms (Err error) ->
            let
                oldScreeningForm =
                    model.screeningForm

                updatedScreeningForm =
                    { oldScreeningForm | rooms = Failure "Something went wrong" }
            in
                { model | screeningForm = updatedScreeningForm } ! []

        FetchMovies (Ok response) ->
            let
                oldScreeningForm =
                    model.screeningForm

                updatedScreeningForm =
                    { oldScreeningForm | movies = Success response }
            in
                { model | screeningForm = updatedScreeningForm } ! []

        FetchMovies (Err error) ->
            let
                oldScreeningForm =
                    model.screeningForm

                updatedScreeningForm =
                    { oldScreeningForm | movies = Failure "Something went wrong" }
            in
                { model | screeningForm = updatedScreeningForm } ! []

        Save ->
            model ! [ createScreening model.screeningForm ]

module ScreeningList.Update exposing (..)

import ScreeningList.Messages exposing (..)
import ScreeningList.Commands exposing (deleteScreening)
import Model exposing (..)
import Navigation
import Routing exposing (toPath, Route(..))
import List.Extra exposing (filterNot)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        FetchScreenings (Ok response) ->
            { model | screeningList = Success response } ! []

        FetchScreenings (Err error) ->
            { model | screeningList = Failure "Something went wrong" } ! []

        HandleDeleteScreeningClick room ->
            model ! [ deleteScreening room ]

        GoToNewScreening ->
            model ! []

        -- [ Navigation.newUrl (toPath NewScreeningRoute) ]
        ScreeningDeleted deletedScreening (Ok _) ->
            let
                updatedScreeningList =
                    case model.screeningList of
                        Success result ->
                            filterNot (\r -> deletedScreening.id == r.id) result

                        _ ->
                            []
            in
                { model | screeningList = Success updatedScreeningList } ! []

        ScreeningDeleted deletedScreening (Err error) ->
            let
                _ =
                    Debug.log "Error deleting screening " error
            in
                model ! []

module Main exposing (..)

import Navigation
import View exposing (view)
import Model exposing (..)
import Update exposing (..)
import Messages exposing (Msg(..))
import Routing exposing (..)
import Helpers exposing (getRoute)


init : Flags -> Navigation.Location -> ( Model, Cmd Msg )
init flags location =
    let
        currentRoute =
            getRoute flags.sessionData location
    in
        urlUpdate currentRoute (initialModel flags.sessionData currentRoute)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Flags Model Msg
main =
    Navigation.programWithFlags OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

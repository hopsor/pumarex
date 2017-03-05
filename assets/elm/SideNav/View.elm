module SideNav.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import SideNav.Messages exposing (..)
import Routing exposing (toPath, Route(..))
import Model exposing (..)
import Navigation
import Routing exposing (toPath, Route(..))


sideNavView : Model -> Html Msg
sideNavView model =
    let
        moviesNavClass =
            classList [ ( "current", model.route == Routing.MoviesRoute ) ]
    in
        nav []
            [ ul []
                [ li [ moviesNavClass, onClick GoToMovies ]
                    [ div [ class "icon icon-video" ] []
                    , text "Movies"
                    ]
                , li []
                    [ div [ class "icon icon-layout" ] []
                    , text "Rooms"
                    ]
                , li []
                    [ div [ class "icon icon-calendar" ] []
                    , text "Screenings"
                    ]
                , li []
                    [ div [ class "icon icon-ticket" ] []
                    , text "Box Office"
                    ]
                ]
            ]

module SideNav.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Messages exposing (..)
import Routing exposing (toPath, Route(..))
import Model exposing (..)


sideNavView : Model -> Html Msg
sideNavView model =
    let
        moviesNavClass =
            classList [ ( "current", model.route == Routing.MoviesRoute ) ]
    in
        nav []
            [ ul []
                [ li [ moviesNavClass ]
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

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
        isMovieRoute =
            (model.route == Routing.MoviesRoute || model.route == Routing.NewMovieRoute)

        moviesNavClass =
            classList [ ( "current", isMovieRoute ) ]

        roomsNavClass =
            classList [ ( "current", model.route == Routing.RoomsRoute || model.route == Routing.NewRoomRoute ) ]

        screeningsNavClass =
            classList [ ( "current", model.route == Routing.ScreeningsRoute ) ]
    in
        nav []
            [ ul []
                [ li [ moviesNavClass, onClick GoToMovies ]
                    [ div [ class "icon icon-video" ] []
                    , text "Movies"
                    ]
                , li [ roomsNavClass, onClick GoToRooms ]
                    [ div [ class "icon icon-layout" ] []
                    , text "Rooms"
                    ]
                , li [ screeningsNavClass, onClick GoToScreenings ]
                    [ div [ class "icon icon-calendar" ] []
                    , text "Screenings"
                    ]
                , li []
                    [ div [ class "icon icon-ticket" ] []
                    , text "Box Office"
                    ]
                ]
            ]

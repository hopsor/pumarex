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
            case model.route of
                Routing.MoviesRoute ->
                    True

                Routing.NewMovieRoute ->
                    True

                Routing.EditMovieRoute _ ->
                    True

                Routing.MovieRoute _ ->
                    True

                _ ->
                    False

        moviesNavClass =
            classList [ ( "current", isMovieRoute ) ]

        roomsNavClass =
            classList [ ( "current", model.route == Routing.RoomsRoute || model.route == Routing.NewRoomRoute ) ]

        screeningsNavClass =
            classList [ ( "current", model.route == Routing.ScreeningsRoute || model.route == Routing.NewScreeningRoute ) ]

        boxOfficeNavClass =
            classList [ ( "current", model.route == Routing.BoxOfficeRoute ) ]
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
                , li [ boxOfficeNavClass, onClick GoToBoxOffice ]
                    [ div [ class "icon icon-ticket" ] []
                    , text "Box Office"
                    ]
                ]
            ]

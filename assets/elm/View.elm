module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Messages exposing (..)
import Routing exposing (toPath, Route(..))
import SideNav.View exposing (sideNavView)
import Home.View exposing (homeView)
import MovieForm.View
import MovieList.View
import RoomForm.View
import RoomList.View
import ScreeningList.View
import Navigation


view model =
    div [ class "wrapper" ]
        [ header [] [ h1 [] [ text "Pumarex" ] ]
        , div [ class "subwrapper" ]
            [ sideNav model
            , main_ []
                [ page model ]
            ]
        ]


sideNav : Model -> Html Msg
sideNav model =
    Html.map SideNavMsg <| sideNavView model


page : Model -> Html Msg
page model =
    case model.route of
        RootRoute ->
            Html.map HomeMsg <| homeView model

        NewMovieRoute ->
            Html.map MovieFormMsg <| MovieForm.View.formView model

        MoviesRoute ->
            Html.map MovieListMsg <| MovieList.View.indexView model

        NewRoomRoute ->
            Html.map RoomFormMsg <| RoomForm.View.formView model

        RoomsRoute ->
            Html.map RoomListMsg <| RoomList.View.indexView model

        ScreeningsRoute ->
            Html.map ScreeningListMsg <| ScreeningList.View.indexView model

        NotFoundRoute ->
            notFoundView


notFoundView : Html Msg
notFoundView =
    div
        [ id "error_index" ]
        [ div
            [ class "warning" ]
            [ span
                [ class "fa-stack" ]
                [ i
                    [ class "fa fa-meh-o fa-stack-2x" ]
                    []
                ]
            , h4
                []
                [ text "404" ]
            ]
        ]

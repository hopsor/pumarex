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
import ScreeningForm.View
import ScreeningList.View
import SessionForm.View
import Navigation


view : Model -> Html Msg
view model =
    div
        [ class "wrapper" ]
        [ headerView model
        , div
            [ class "subwrapper" ]
            [ sideNav model
            , main_
                []
                [ page model ]
            ]
        ]


headerView : Model -> Html Msg
headerView model =
    header
        []
        [ h1
            []
            [ text "Pumarex" ]
        , div
            [ class "menu" ]
            [ div
                [ class "current-user" ]
                [ img
                    [ class "avatar", src model.session.avatarUrl ]
                    []
                , span
                    [ class "username" ]
                    [ text model.session.firstName ]
                ]
            , button
                [ class "unstyled", onClick Logout ]
                [ text "Logout" ]
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

        NewScreeningRoute ->
            Html.map ScreeningFormMsg <| ScreeningForm.View.formView model

        ScreeningsRoute ->
            Html.map ScreeningListMsg <| ScreeningList.View.indexView model

        NewSessionRoute ->
            Html.map SessionFormMsg <| SessionForm.View.formView model

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

module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Messages exposing (..)
import Routing exposing (toPath, Route(..))
import Home.View exposing (homeView)
import MovieList.View exposing (indexView)
import Navigation

view model =
  let
    moviesNavClass = classList [("current", model.route == Routing.MoviesRoute)]

  in
    div [ class "wrapper" ]
    [ header [] [ h1 [] [ text "Pumarex"] ]
    , div [ class "subwrapper" ]
      [ nav []
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
      , main_ []
        [ page model ]
      ]
    ]

page : Model -> Html Msg
page model =
    case model.route of
        RootRoute ->
            Html.map HomeMsg <| homeView model

        MoviesRoute ->
            Html.map MovieListMsg <| indexView model

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

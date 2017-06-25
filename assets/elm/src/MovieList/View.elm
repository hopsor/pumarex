module MovieList.View exposing (..)

import MovieList.Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Routing exposing (toPath, onPreventDefaultClick, Route(..))


indexView : Model -> Html Msg
indexView model =
    div [ id "movie_list" ]
        [ contentView model ]


contentView : Model -> Html Msg
contentView model =
    case model.movieList of
        NotRequested ->
            p [] [ text "Movies not loaded" ]

        Requesting ->
            div [ class "loading" ] [ text "Loading ..." ]

        Failure error ->
            div [ class "error" ] [ text error ]

        Success result ->
            movieList result


movieList : MovieList -> Html Msg
movieList resultset =
    ul []
        ((List.map movieItem resultset.entries) ++ [ addItemButton ])


movieItem : Movie -> Html Msg
movieItem movie =
    let
        posterStyle =
            style [ ( "backgroundImage", "url(" ++ movie.poster ++ ")" ) ]
    in
        li
            [ class "movie-item" ]
            [ a
                [ href (toPath (MovieRoute movie.id))
                , onPreventDefaultClick (GoToMovie movie.id)
                ]
                [ div
                    [ class "poster", posterStyle ]
                    []
                , span
                    []
                    [ text movie.title ]
                ]
            ]


addItemButton : Html Msg
addItemButton =
    li
        [ class "add-movie-item" ]
        [ a
            [ class "button"
            , href (toPath NewMovieRoute)
            , onPreventDefaultClick GoToNewMovie
            ]
            [ span
                []
                [ text "Add new movie" ]
            ]
        ]

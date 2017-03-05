module MovieList.View exposing (..)

import MovieList.Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)


indexView : Model -> Html Msg
indexView model =
    div [ id "movie_list" ]
        [ h1 [] [ text "Movie List" ]
        , contentView model
        ]


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
    if List.isEmpty resultset.entries then
        p [] [ text "There isn't any movie" ]
    else
        ul []
            (List.map movieItem resultset.entries)


movieItem : Movie -> Html Msg
movieItem movie =
    li []
        [ text movie.title ]

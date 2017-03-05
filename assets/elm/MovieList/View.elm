module MovieList.View exposing (..)

import MovieList.Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)


indexView : Model -> Html Msg
indexView model =
    div [ id "movie_list" ]
        [ h1 [] [ text "Movie List" ]
        , movieList model
        ]


movieList : Model -> Html Msg
movieList model =
    if List.isEmpty model.movieList.entries then
        p [] [ text "There isn't any movie" ]
    else
        ul []
            (List.map movieItem model.movieList.entries)


movieItem : Movie -> Html Msg
movieItem movie =
    li []
        [ text movie.title ]

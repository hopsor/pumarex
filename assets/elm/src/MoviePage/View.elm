module MoviePage.View exposing (..)

import MoviePage.Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)


movieView : Model -> Html Msg
movieView model =
    case model.movie of
        NotRequested ->
            p [] [ text "Movies not loaded" ]

        Requesting ->
            div [ class "loading" ] [ text "Loading ..." ]

        Failure error ->
            div [ class "error" ] [ text error ]

        Success result ->
            movieCardView result


movieCardView : Movie -> Html Msg
movieCardView movie =
    div
        [ id "movie_page" ]
        [ text movie.title ]

module MoviePage.View exposing (..)

import MoviePage.Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Routing exposing (toPath, onPreventDefaultClick, Route(..))


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
        [ h1
            []
            [ text "Movie details" ]
        , div
            [ class "movie-details" ]
            [ div
                [ class "poster-wrapper" ]
                [ img
                    [ class "poster", src movie.poster ]
                    []
                , a
                    [ class "button"
                    , href (toPath (EditMovieRoute movie.id))
                    , onPreventDefaultClick (GoToEditMovie movie.id)
                    ]
                    [ text "Edit movie" ]
                , a
                    [ class "button button-unfilled"
                    , href (toPath MoviesRoute)
                    , onPreventDefaultClick GoToMovies
                    ]
                    [ text "Browse movies" ]
                ]
            , div
                [ class "info-wrapper" ]
                [ infoBitView "Title" movie.title
                , infoBitView "Year" (toString movie.year)
                , infoBitView "Director" movie.director
                , infoBitView "Cast" movie.cast
                , infoBitView "Overview" movie.overview
                , infoBitView "Duration" ((toString movie.duration) ++ " minutes")
                ]
            ]
        ]


infoBitView : String -> String -> Html Msg
infoBitView heading content =
    div
        [ class "info-bit" ]
        [ div
            [ class "info-bit-heading" ]
            [ text heading ]
        , div
            [ class "info-bit-content" ]
            [ text content ]
        ]

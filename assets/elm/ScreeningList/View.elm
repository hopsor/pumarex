module ScreeningList.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import ScreeningList.Messages exposing (..)
import Model exposing (..)


indexView : Model -> Html Msg
indexView model =
    div [ id "screening_list", class "portlet" ]
        [ header [] [ text "Screening listing" ]
        , div
            [ class "portlet-body" ]
            [ contentView model
            , actionsView
            ]
        ]


actionsView : Html Msg
actionsView =
    div
        [ class "actions" ]
        [ addItemButton ]


contentView : Model -> Html Msg
contentView model =
    case model.screeningList of
        NotRequested ->
            p [] [ text "Screenings not loaded" ]

        Requesting ->
            div [ class "loading" ] [ text "Loading ..." ]

        Failure error ->
            div [ class "error" ] [ text error ]

        Success result ->
            screeningTable result


screeningTable : ScreeningList -> Html Msg
screeningTable resultset =
    if not (List.isEmpty resultset) then
        table [ class "table" ]
            [ thead []
                [ th [ class "movie-name" ] [ text "Movie" ]
                , th [ class "room-name" ] [ text "Room" ]
                , th [ class "screened-at" ] [ text "Date" ]
                , th [] []
                ]
            , tbody [] (List.map screeningTableRow resultset)
            ]
    else
        p [ class "empty" ] [ text "You haven't added any screening yet." ]


screeningTableRow : Screening -> Html Msg
screeningTableRow screening =
    tr []
        [ td [] [ text screening.movie.title ]
        , td [] [ text screening.room.name ]
        , td [] [ text screening.screenedAt ]
        , td
            [ class "actions" ]
            [ button [ onClick (HandleDeleteScreeningClick screening) ]
                [ text "Delete" ]
            ]
        ]


addItemButton : Html Msg
addItemButton =
    button
        [ onClick GoToNewScreening ]
        [ text "New Screening" ]

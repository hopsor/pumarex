module SessionForm.View exposing (..)

import SessionForm.Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)


formView : Model -> Html Msg
formView model =
    div
        [ id "session" ]
        [ Html.form
            [ id "session_form", onSubmit Authenticate ]
            [ h1
                []
                [ text "Pumarex" ]
            , errorMessage model.sessionForm.authenticationFailed
            , div
                [ class "field" ]
                [ input
                    [ type_ "text", placeholder "Email", onInput EmailUpdated ]
                    []
                ]
            , div
                [ class "field" ]
                [ input
                    [ type_ "password", placeholder "Password", onInput PasswordUpdated ]
                    []
                ]
            , div
                [ class "actions" ]
                [ button
                    [ type_ "submit" ]
                    [ text "Log in" ]
                ]
            ]
        ]


errorMessage : Bool -> Html Msg
errorMessage failStatus =
    case failStatus of
        True ->
            div
                [ class "alert alert-error" ]
                [ text "Authentication failed!" ]

        False ->
            text ""

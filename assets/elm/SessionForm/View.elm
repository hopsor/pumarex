module SessionForm.View exposing (..)

import SessionForm.Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)


formView : Model -> Html Msg
formView model =
    Html.form
        [ id "session_form" ]
        [ h1
            []
            [ text "Login" ]
        , div
            [ class "field" ]
            [ input
                [ type_ "text", placeholder "Email" ]
                []
            ]
        , div
            [ class "field" ]
            [ input
                [ type_ "password", placeholder "Password" ]
                []
            ]
        , div
            [ class "actions" ]
            [ button
                [ type_ "button", onClick Authenticate ]
                [ text "Save" ]
            ]
        ]

module Main exposing (..)

import Html exposing (div, header, h1, nav, main_, ul, li, text)
import Html.Attributes exposing (..)

main =
  div [ class "wrapper" ]
  [ header [] [ h1 [] [ text "Pumarex"] ]
  , div [ class "subwrapper" ]
    [ nav []
      [ ul []
        [ li []
          [ div [ class "icon icon-video" ] []
          , text "Movies"
          ]
        , li [ class "current" ]
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
      [ text "It works" ]
    ]
  ]

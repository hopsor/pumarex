module Main exposing (..)

import Html exposing (div, header, nav, main_, ul, li, text)
import Html.Attributes exposing (..)

main =
  div [ class "wrapper" ]
  [ header [] []
  , nav []
    [ ul []
      [ li [] [ text "Movies" ]
      , li [] [ text "Rooms" ]
      , li [] [ text "Screenings" ]
      , li [] [ text "Box Office" ]
      ]
    ]
  , main_ []
    [ text "It works" ]
  ]

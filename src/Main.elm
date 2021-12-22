module Main exposing (main)

import Html exposing (..)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid

main =
    Grid.container []
        [ CDN.stylesheet -- creates an inline style node with the Bootstrap CSS
        , Grid.row []
            [ Grid.col []
                [ h2 [] [ text "99 Elm"] ]
            ]

        ]

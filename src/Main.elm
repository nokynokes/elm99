module Main exposing (main)

import Html exposing (..)
import Browser
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Button as Button

type alias Model = {}

type Msg = NoOp

update : Msg -> Model -> Model
update msg model =
  case msg of
    NoOp -> model

view : Model -> Html Msg
view model =
    Grid.container []
        [ CDN.stylesheet -- creates an inline style node with the Bootstrap CSS
        , Grid.row []
            [ Grid.col []
                [ h1 [] [ text "99 Elm"] ]
            ]
        , Grid.row []
            [ Grid.col []
                [ Button.button [ Button.primary ] [ text "List Problems"] ]
            ]
        ]


main =
  Browser.sandbox {
    init = {}
    , view = view
    , update = update
  }

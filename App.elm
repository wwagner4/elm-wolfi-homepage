import StartApp.Simple exposing (start)
import Html exposing (div, button, text, Html)

import Html.Events exposing (onClick)
import Html.Attributes exposing (style)

import Html.Events exposing (onClick)
import Signal exposing (Address)


main =
  start { model = initial, update = update, view = view }

-- MODEL

type alias Model =
  { x : Int
  , y : Int
  }

initial : Model
initial = {x = 100, y = 400}

-- UPDATE

type Action = Reset | Up | Down

update : Action -> Model -> Model
update action model =
  case action of
    Up -> { model |y = model.y - 10}
    Down -> { model |y = model.y + 10}
    Reset -> initial


-- VIEW

top: Model -> String
top model = (toString model.y) ++ "px"

movingDiv : Model -> Html
movingDiv model =
    div [style [
      ("position", "absolute")
      , ("width", "200px")
      , ("height", "100px")
      , ("background-color", "blue")
      , ("left", "10px")
      , ("top", top model)
    ]] []


view : Signal.Address Action -> Model -> Html
view address model =
  div []
    [ button [ onClick address Up ] [ text "UP" ]
    , movingDiv model
    , button [ onClick address Down ] [ text "DOWN" ]
    , button [ onClick address Reset ] [ text "RESET" ]
    ]
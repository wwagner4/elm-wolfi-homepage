import StartApp.Simple exposing (start)
import Html exposing (div, button, text, Html)
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
initial = {x = 0, y = 0}

-- UPDATE

type Action = Reset | Up | Down

update : Action -> Model -> Model
update action model =
  case action of
    Up -> model
    Down -> { model |y = model.y - 10}
    Reset -> initial


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  div []
    [ button [ onClick address Up ] [ text "UP" ]
    , button [ onClick address Down ] [ text "DOWN" ]
    ]
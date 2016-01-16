
type alias PanelDim = {
  w : Float
  , h : Float
}

type alias Pos = {
  x: Float
  , y : Float
}

type alias Elem = {
  pos : Pos
}

type alias Model = {
  elem : Elem
}


initialPos : Pos
initialPos = { x = 0.0, y = 0.0 }

initialElem : Elem
initialElem = { pos = initialPos }

initial : Model
initial = { elem = initialElem }

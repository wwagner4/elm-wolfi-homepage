
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


updatePos : PanelDim -> Pos -> Pos
updatePos panel pos = { pos |
  x = 0.0 ,
  y = 0.0 }

updateElem : PanelDim -> Elem -> Elem
updateElem panel elem = { elem |
  pos = updatePos panel elem.pos }


update : PanelDim -> Model -> Model
update panel model = { model |
  elem = updateElem panel model.elem }

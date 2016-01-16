import Random exposing (..)


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
  seed : Seed
  , elem : Elem
}

diffGen : Generator Float
diffGen = Random.float -2.0 2.0


initialPos : Pos
initialPos = { x = 0.0, y = 0.0 }


initialElem : Elem
initialElem = { pos = initialPos }


initial : Model
initial = {
  seed = initialSeed 0
  , elem = initialElem }


ranDiff : Float
ranDiff = 0.1

updateX : PanelDim -> Pos -> Float
updateX panel pos = pos.x + ranDiff


updateY : PanelDim -> Pos -> Float
updateY panel pos = pos.y + ranDiff


updatePos : PanelDim -> Pos -> Pos
updatePos panel pos = { pos |
  x = updateX panel pos  ,
  y = updateY panel pos }

updateElem : PanelDim -> Elem -> Elem
updateElem panel elem = { elem |
  pos = updatePos panel elem.pos }


update : PanelDim -> Model -> Model
update panel model = { model |
  elem = updateElem panel model.elem }

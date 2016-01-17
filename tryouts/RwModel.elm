module RwModel where

import Random exposing (..)
import Time exposing (..)


type alias PanelDim = {
  w : Float
  , h : Float
}

type alias Inp = {
  time : Time
  , panelDim : PanelDim
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

initialPos : Pos
initialPos = { x = 0.0, y = 0.0 }


initialElem : Elem
initialElem = { pos = initialPos }


initial : Model
initial = {
  seed = initialSeed 821736182376
  , elem = initialElem }


diffGen : Generator Float
diffGen = Random.float -20.0 20.0


ranDiff : Seed -> (Float, Seed)
ranDiff seed = generate diffGen seed

updateX : PanelDim -> Seed -> Pos -> (Float, Seed)
updateX panel seed pos =
  let
    (diff, seed) = ranDiff seed
    x = pos.x + diff
  in
    (x, seed)


updateY : PanelDim -> Seed -> Pos -> (Float, Seed)
updateY panel seed pos =
  let
    (diff, seed) = ranDiff seed
    y = pos.y + diff
  in
    (y, seed)


updatePos : PanelDim -> Seed -> Pos -> (Pos, Seed)
updatePos panel seed pos =
  let
    (x, s1) = updateX panel seed pos
    (y, s2) = updateY panel s1 pos
    pos = { pos | x = x , y = x }
  in
    (pos, s2)


updateElem : PanelDim -> Seed -> Elem -> (Elem, Seed)
updateElem panel seed elem =
  let
    (pos, seed) = updatePos panel seed elem.pos
    elem = { elem | pos = pos }
  in
    (elem, seed)


update : Inp -> Model -> Model
update inp model =
  let
    (elem, seed) = updateElem inp.panelDim model.seed model.elem
  in
    { model |
      elem = elem
      , seed = seed}

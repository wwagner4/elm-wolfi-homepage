module RwModel where

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
  , elems : List Elem
}

initialPos : Pos
initialPos = { x = 0.0, y = 0.0 }


initialElem : Elem
initialElem = { pos = initialPos }


initial : Model
initial = {
  seed = initialSeed 821736182376
  , elems = List.repeat 100 initialElem }


diffVal : Float
diffVal = 1.0


diffGen : Generator Float
diffGen = Random.float -diffVal diffVal


ranDiff : Seed -> (Float, Seed)
ranDiff seed = generate diffGen seed

updateX : PanelDim -> Seed -> Pos -> (Float, Seed)
updateX panel seed pos =
  let
    (diff, nextSeed) = ranDiff seed
    max = panel.w / 2.0
    corr1 = if (pos.x > max * 0.9) then -diffVal else 0
    corr2 = if (pos.x < -max * 0.9) then diffVal else 0
    x = pos.x + diff + corr1 + corr2
  in
    (x, nextSeed)


updateY : PanelDim -> Seed -> Pos -> (Float, Seed)
updateY panel seed pos =
  let
    (diff, nextSeed) = ranDiff seed
    max = panel.h / 2.0
    corr1 = if (pos.y > max * 0.9) then -diffVal else 0
    corr2 = if (pos.y < -max * 0.9) then diffVal else 0
    y = pos.y + diff + corr1 + corr2
  in
    (y, nextSeed)


updatePos : PanelDim -> Seed -> Pos -> (Pos, Seed)
updatePos panel seed pos =
  let
    (x, s1) = updateX panel seed pos
    (y, s2) = updateY panel s1 pos
    nextPos = { pos | x = x , y = y }
  in
    (nextPos, s2)


updateElem : PanelDim -> Seed -> Elem -> (Elem, Seed)
updateElem panel seed elem =
  let
    (pos, nextSeed) = updatePos panel seed elem.pos
    nextElem = { elem | pos = pos }
  in
    (nextElem, nextSeed)


updateElem1 : Elem -> (List Elem, Seed, PanelDim) -> (List Elem, Seed, PanelDim)
updateElem1 elem (elems, seed, panelDim) =
  let
    (nextElem, nextSeed) = updateElem panelDim seed elem
    nextElems = nextElem :: elems
  in
    (nextElems, nextSeed, panelDim)


update : PanelDim -> Model -> Model
update panelDim model =
  let
    (nextElems, nextSeed, panelDim) =
      List.foldl
        updateElem1
        ([], model.seed, panelDim)
        model.elems
  in
    { model |
      elems = nextElems
      , seed = nextSeed }

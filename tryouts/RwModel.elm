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
  , elems = List.repeat 500 initialElem }


diffGen : Generator Float
diffGen = Random.float -5.0 5.0


ranDiff : Seed -> (Float, Seed)
ranDiff seed = generate diffGen seed

updateX : PanelDim -> Seed -> Pos -> (Float, Seed)
updateX panel seed pos =
  let
    (diff, nextSeed) = ranDiff seed
    x = pos.x + diff
  in
    (x, nextSeed)


updateY : PanelDim -> Seed -> Pos -> (Float, Seed)
updateY panel seed pos =
  let
    (diff, nextSeed) = ranDiff seed
    y = pos.y + diff
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

import RwModel exposing (..)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Color exposing (..)


shape : Shape
shape = square 10.0

form : Shape -> Form
form shape = filled Color.red shape


toForm : Elem -> Form
toForm elem = form shape


view : PanelDim -> Model -> Element
view panel model =
  let
    w = round panel.w
    h = round panel.h
  in
    collage w h [toForm model.elem]


dim : PanelDim
dim = {w = 400.0, h = 400.0}


main : Element
main = view dim RwModel.initial

module Elem where

import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Text exposing (..)
import Window exposing (..)


txtHeight1 : number
txtHeight1 = 30

txtHeight2 : number
txtHeight2 = 20

contWidth : number
contWidth = 300

contHeight : number
contHeight = 250

typefaces : List String
typefaces = ["Chunkfive", "Monospace"]

type alias Elem =
  { title : String,
    subTitle : String,
    imageUrl : String
  }

txt : String -> Int -> Element
txt str h = str
  |> fromString
  |> typeface typefaces
  |> Text.height (toFloat h)
  |> centered

txtCentered : String -> Int -> Element
txtCentered str h = container contWidth (h + 10) middle (txt str h)

txtElem : Elem -> Element
txtElem elem = flow down [
  txtCentered elem.title txtHeight1,
  txtCentered elem.subTitle txtHeight2]


txtElemCentered : Elem -> Element
txtElemCentered elem = container contWidth contHeight middle (txtElem elem)


elemCont : Element -> Element
elemCont el = container contWidth (heightOf el) middle el


elemElem : Elem -> Element
elemElem elem = flow inward [
  txtElemCentered elem,
  elemCont (opacity 0.5 (fittedImage contWidth contHeight elem.imageUrl))]


elemForm : Elem -> Float -> Float -> Form
elemForm elem x y = elemElem elem
  |> toForm
  |> move (x, y)




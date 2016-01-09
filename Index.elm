import Elem exposing (Elem, elemForm)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Window exposing (..)


ww : Elem
ww = {
  title = "Wolfgang Wagner",
  subTitle = "yet another programmer",
  imageUrl = "ww.jpg"}

cn : Elem
cn = {
  title = "Chuck Norris",
  subTitle = "looser",
  imageUrl = "cn.jpg"}


elemPlane : (Int, Int) -> Element
elemPlane (x, y) = collage x y [
  elemForm cn 200 -200,
  elemForm ww 0 0]

main : Signal Element
main = Signal.map elemPlane Window.dimensions


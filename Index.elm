import Elem exposing (Elem, elemForm)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Window exposing (..)
import Time exposing (..)


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

pos : Time -> Float
pos t = -500.0 + toFloat(round(t) % 1000)


elemPlane : (Int, Int) -> Time -> Element
elemPlane (x, y) t = collage x y [
  elemForm cn (pos t) 0,
  elemForm ww 0 (pos t)]

main : Signal Element
main = Signal.map2 elemPlane Window.dimensions (Time.every (Time.second * 0.0001))


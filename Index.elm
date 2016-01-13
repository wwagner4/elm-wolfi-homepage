import Elem exposing (Elem, elemForm)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Window exposing (..)
import Time exposing (..)
import Mouse exposing (..)


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
pos t = 500 * (sin (t * 0.001))


elemPlane : (Int, Int) -> Time -> Int -> Element
elemPlane (x, y) t c = collage x y [
  elemForm cn (pos t) ((toFloat c) * 100),
  elemForm ww 0 (pos t)]

countClick : Signal Int
countClick =
  Signal.foldp (\clk count -> count + 1) 0 Mouse.clicks

main : Signal Element
main = Signal.map3 elemPlane Window.dimensions (Time.every (Time.second * 0.01)) countClick


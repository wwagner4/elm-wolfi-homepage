import Elem exposing (Elem, elemForm)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Window exposing (..)
import Time exposing (..)
import Mouse exposing (..)


type alias PosElem = {
  pos : (Float, Float)
  , elem : Elem
}


type alias Model = {
  elems : List PosElem
}


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

view : (Int, Int) -> Time -> (Int, Int) -> Element
view (w, h) t (x, y) = collage w h [
  elemForm cn (pos t) (toFloat x),
  elemForm ww 0 (pos t)]

time : Signal Time
time = Time.every (Time.second * 0.01)


mousePos : Signal (Int, Int)
mousePos =
  Signal.sampleOn Mouse.clicks Mouse.position


main : Signal Element
main = Signal.map3
  view Window.dimensions
  time
  mousePos


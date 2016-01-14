import Elem exposing (Elem, elemForm)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Window exposing (..)
import Time exposing (..)
import Mouse exposing (..)


type alias MousePos = (Int, Int)

type alias ScreenSize = (Int, Int)

type alias PosElem = {
  pos : (Float, Float)
  , elem : Elem
}


type alias Model = {
  elems : List PosElem
}

type alias Input = {
  time: Time
  , mousePos: MousePos
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


initial : Model
initial = { elems = [
  { pos = (0, 0), elem = ww }
  , { pos = (0, 0), elem = cn }]
  }


pos : Time -> Float
pos t = 400 * (sin (t * 0.002))

view : ScreenSize -> Model -> Element
view (w, h) model = collage w h [
  elemForm cn 10 10,
  elemForm ww -10 -10]

updateElem : Time -> MousePos -> PosElem -> PosElem
updateElem time mousePos posElem = posElem


update : Input -> Model -> Model
update input model =
  { model |elems = List.map
    (updateElem input.time input.mousePos)
    model.elems
  }


time : Signal Time
time = Time.every (Time.second * 0.001)


mousePos : Signal MousePos
mousePos =
  Signal.sampleOn Mouse.clicks Mouse.position


input : Time
  -> MousePos
  -> Input
input time mousePos = {
  time = time
  , mousePos = mousePos}


main : Signal Element
main = Signal.map2
  view
  Window.dimensions
  (Signal.foldp
    update
    initial
    (Signal.map2 input time mousePos))

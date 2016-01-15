import Elem exposing (Elem, elemForm)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Window exposing (..)
import Time exposing (..)
import Mouse exposing (..)


type alias MousePos = (Int, Int)

type alias ScreenSize = (Int, Int)

type alias PosElem = {
  offset : Float
  , pos : (Float, Float)
  , elem : Elem
}


type alias Model = {
  latestMousePos: MousePos
  , elems : List PosElem
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
initial = {
  latestMousePos = (0, 0)
  , elems = [
  { offset = 20, pos = (0, 0), elem = ww }
  , { offset = 40, pos = (0, 0), elem = cn }]
  }


pos : Float -> Time -> Float
pos off t = 400 * (sin ((t * 0.002) + off))


posFromTime : Float -> Time -> (Float, Float)
posFromTime off t = (pos off t, pos -off t)


toForm : Elem -> (Float, Float) -> Form
toForm elem (x, y) = elemForm elem x y


view : ScreenSize -> Model -> Element
view (w, h) model = collage w h (List.map (\pe -> toForm pe.elem pe.pos) model.elems)


updateElem : Time -> MousePos -> PosElem -> PosElem
updateElem time mousePos posElem = { posElem | pos = posFromTime posElem.offset time }


update : Input -> Model -> Model
update input model =
  { model | elems = List.map
    (updateElem input.time input.mousePos)
    model.elems
  }


time : Signal Time
time = Time.every (Time.millisecond * 1)


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

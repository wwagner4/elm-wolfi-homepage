import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Text exposing (..)

txtHeight1 = 35
txtHeight2 = 15
contWidth = 350
contHeight = 250
typefaces = ["sans-serif"]

type alias Elem =
  { title : String,
    subTitle : String,
    imageUrl : String
  }

ww : Elem
ww = {
  title = "Wolfgang Wagner",
  subTitle = "yet another programmer",
  imageUrl = "ww.jpg"}


txt : String -> Int -> Element
txt str h = str
  |> fromString
  |> typeface typefaces
  |> Text.height (toFloat h)
  |> centered

txtCentered : String -> Int -> Element
txtCentered str h = container contWidth (h + 10) middle (txt str h)

elemCont elem = container contWidth (heightOf elem)  middle elem

txtElem : Elem -> Element
txtElem elem = flow down [
  txtCentered elem.title txtHeight1,
  txtCentered elem.subTitle txtHeight2]


txtElemCentered : Elem -> Element
txtElemCentered elem = container contWidth contHeight middle (txtElem elem)

allFlow : Elem -> Element
allFlow elem = flow inward [
  txtElemCentered elem,
  elemCont (opacity 0.5 (fittedImage contWidth contHeight elem.imageUrl))]

allForm : Float -> Float -> Form
allForm x y = allFlow ww
  |> toForm
  |> move (x, y)

main : Element
main = collage 700 700 [allForm 0 0]

import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Text exposing (..)

txtHeight1 = 35
txtHeight2 = 15
contWidth = 350
contHeight = 350
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

ww1 : Elem
ww1 = {
  title = "Juck Norris",
  subTitle = "looser",
  imageUrl = "jn.jpg"}


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

elemCont elem = container contWidth (heightOf elem)  middle elem

elemElem : Elem -> Element
elemElem elem = flow inward [
  txtElemCentered elem,
  elemCont (opacity 0.5 (fittedImage contWidth contHeight elem.imageUrl))]

elemForm : Elem -> Float -> Float -> Form
elemForm elem x y = elemElem elem
  |> toForm
  |> move (x, y)

main : Element
main = collage 700 700 [
  elemForm ww1 200 200,
  elemForm ww 0 0]

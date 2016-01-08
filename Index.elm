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


txtElem : String -> Int -> Element
txtElem str h = str
  |> fromString
  |> typeface typefaces
  |> Text.height (toFloat h)
  |> centered

txtCont : String -> Int -> Element
txtCont str h = container contWidth (h + 10) middle (txtElem str h)
elemCont elem = container contWidth (heightOf elem)  middle elem

txtFlow : Elem -> Element
txtFlow elem = flow down [
  txtCont elem.title txtHeight1,
  txtCont elem.subTitle txtHeight2]


txtCont1 : Elem -> Element
txtCont1 elem = container contWidth contHeight middle (txtFlow elem)

allFlow : Elem -> Element
allFlow elem = flow inward [
  txtCont1 elem,
  elemCont (opacity 0.5 (fittedImage contWidth contHeight elem.imageUrl))]

allForm = allFlow ww
  |> toForm
  |> move (0, 0)

main : Element
main = collage 700 700 [allForm]

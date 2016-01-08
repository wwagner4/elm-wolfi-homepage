import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Text exposing (..)

txtHeight1 = 35
txtHeight2 = 15
contWidth = 350
contHeight = 300
typefaces = ["sans-serif"]


txtElem : String -> Int -> Element
txtElem str h = str
  |> fromString
  |> typeface typefaces
  |> Text.height (toFloat h)
  |> centered

txtCont : String -> Int -> Element
txtCont str h = container contWidth (h + 10) middle (txtElem str h)
elemCont elem = container contWidth (heightOf elem)  middle elem


txtFlow = flow down [
  txtCont "Wolfgang Wagner" txtHeight1,
  txtCont "font of programming" txtHeight2]


txtCont1 = container contWidth contHeight middle txtFlow

allFlow = flow inward [
  txtCont1,
  elemCont (opacity 0.5 (fittedImage contWidth contHeight "ww.jpg"))]


allForm = allFlow |> toForm |> move (0, 0)

main : Element
main = collage 700 700 [allForm]

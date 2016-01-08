import Graphics.Element exposing (..)
import Text exposing (..)

txtHeight1 = 70
txtHeight2 = 30
contWidth = 200
contHeight = 150
typefaces = ["trattatello","arial","sans-serif"]


txtElem : String -> Int -> Element
txtElem str h = str
  |> fromString
  |> typeface typefaces
  |> Text.height (toFloat h)
  |> centered

txtCont : String -> Int -> Element
txtCont str h = container contWidth (h + 5) middle (txtElem str h)
elemCont elem = container contWidth (heightOf elem)  middle elem


txtFlow = flow down [
  txtCont "Hallo" txtHeight1,
  txtCont "Wolfi" txtHeight2]


txtCont1 = container contWidth contHeight middle txtFlow

allFlow = flow inward [
  txtCont1,
  elemCont (opacity 0.5 (fittedImage contWidth contHeight "ww.jpg"))]



main : Element
main = allFlow

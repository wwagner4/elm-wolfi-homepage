import Graphics.Element exposing (..)
import Text exposing (..)

txtHeight = 100
contWidth = 400
contHeight = 300

txtElem : String -> Element
txtElem str = str |> fromString |> Text.height txtHeight |> centered

txtCont str = container contWidth (txtHeight + 5) middle (txtElem str)
elemCont elem = container contWidth (heightOf elem)  middle elem


txtFlow = flow down [
  txtCont "Hallo",
  txtCont "Wolfi"]


txtCont1 = container contWidth contHeight middle txtFlow

allFlow = flow inward [
  txtCont1,
  elemCont (opacity 0.5 (fittedImage contWidth contHeight "ww.jpg"))]



main : Element
main = allFlow

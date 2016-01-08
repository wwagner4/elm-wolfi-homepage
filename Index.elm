import Graphics.Element exposing (..)
import Text exposing (..)

txtHeight = 30

txtElem : String -> Element
txtElem str = str |> fromString |> Text.height txtHeight |> centered

txtCont str = container 300 (txtHeight + 5) middle (txtElem str)
elemCont elem = container 300 (heightOf elem)  middle elem


txtFlow = flow down [
  txtCont "Hallo",
  txtCont "Wolfi"]

allFlow = flow inward [
  txtFlow,
  elemCont (opacity 0.5 (fittedImage 200 150 "ww.jpg"))]



main : Element
main = allFlow

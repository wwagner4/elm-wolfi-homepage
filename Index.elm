import Graphics.Element exposing (..)
import Text exposing (..)

txtElem : String -> Element
txtElem str = str |> fromString |> centered



main : Element
main = txtElem "Hallo Wolfi 1"
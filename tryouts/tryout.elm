import Graphics.Element exposing (..)
import Signal exposing (..)
import Mouse exposing (..)


eventCount : () -> Int -> Int
eventCount unit cnt = cnt + 1

clicksCount : Signal Int
clicksCount = (Signal.foldp eventCount 1 Mouse.clicks)

main = Signal.map show clicksCount

import Graphics.Element exposing (show)
import Signal exposing (map)
import Time exposing (every, second, millisecond)


x a = show a

main = map x (Time.every (Time.millisecond * 10))

module ElmShop.Document.Utils.TimeZone exposing (TimeZone, codec, create, fromInt, toInt)

import Codec
import Task
import Time


type TimeZone
    = TimeZone Int


create : Time.Posix -> Task.Task x TimeZone
create localTime =
    Time.now
        |> Task.map
            (\now ->
                ((Time.posixToMillis localTime - Time.posixToMillis now) // 60000)
                    |> TimeZone
            )


fromInt : Int -> TimeZone
fromInt a =
    TimeZone a


toInt : TimeZone -> Int
toInt (TimeZone a) =
    a


codec : Codec.Codec TimeZone
codec =
    Codec.custom
        (\fn1 x ->
            case x of
                TimeZone x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "TimeZone" TimeZone Codec.int
        |> Codec.buildCustom

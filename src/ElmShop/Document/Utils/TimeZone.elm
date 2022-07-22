module ElmShop.Document.Utils.TimeZone exposing (TimeZone, codec, create, fromInt, toInt, type_)

import Codec
import Dataman.Type
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
        |> Codec.variant1 TimeZone Codec.int
        |> Codec.buildCustom


type_ : Dataman.Type.Type TimeZone
type_ =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Utils", "TimeZone" ] "TimeZone"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "TimeZone", arguments = [ Dataman.Type.toAny (Dataman.Type.Int_ |> Dataman.Type.Opaque_) ] }
            , []
            )
        }

module ElmShop.Document.Utils.Order exposing (Order, codec, default, fromFloat, toFloat, type_)

import Codec
import Dataman.Type


type Order
    = Order Float


fromFloat : Float -> Order
fromFloat =
    Order


toFloat : Order -> Float
toFloat (Order a) =
    a


default : Order
default =
    Order 1


codec : Codec.Codec Order
codec =
    Codec.custom
        (\fn1 x ->
            case x of
                Order x1 ->
                    fn1 x1
        )
        |> Codec.variant1 Order Codec.float
        |> Codec.buildCustom


type_ : Dataman.Type.Type Order
type_ =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Utils", "Order" ] "Order"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Order", arguments = [ Dataman.Type.toAny Dataman.Type.float ] }
            , []
            )
        }

module ElmShop.Document.Utils.Order exposing (Order, codec, default, fromFloat, schema, toFloat)

import Codec
import Dataman.Schema
import Dataman.Schema.Basics


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
        |> Codec.variant1 "Order" Order Codec.float
        |> Codec.buildCustom


schema : Dataman.Schema.Schema Order
schema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Utils", "Order" ] "Order")
        Nothing
        (Dataman.Schema.Variant "Order" [ Dataman.Schema.toAny Dataman.Schema.Basics.float ])
        []

module ElmShop.Document.Utils.Order exposing (Order, codec, default, fromFloat, toFloat)

import Codec


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

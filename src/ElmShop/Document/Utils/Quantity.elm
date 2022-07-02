module ElmShop.Document.Utils.Quantity exposing (Quantity, codec, fromInt, toInt)

import Codec


type Quantity
    = Quantity Int


fromInt : Int -> Maybe Quantity
fromInt a =
    if a > 0 && a < 10000 then
        Just (Quantity a)

    else
        Nothing


toInt : Quantity -> Int
toInt (Quantity a) =
    a


codec : Codec.Codec Quantity
codec =
    Codec.int
        |> Codec.andThen
            (\x ->
                case fromInt x of
                    Just x2 ->
                        Codec.succeed x2

                    Nothing ->
                        Codec.fail "Cannot decode quantity."
            )
            toInt

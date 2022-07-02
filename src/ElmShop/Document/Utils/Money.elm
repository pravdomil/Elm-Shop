module ElmShop.Document.Utils.Money exposing (DecimalPlaces, Money, codec, decimalPlacesCodec, decimalPlacesToInt, fromInt, intToDecimalPlaces, toInt)

import Codec


type Money
    = Money Int


fromInt : Int -> Money
fromInt =
    Money


toInt : Money -> Int
toInt (Money a) =
    a


codec : Codec.Codec Money
codec =
    Codec.custom
        (\fn1 x ->
            case x of
                Money x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "Money" Money Codec.int
        |> Codec.buildCustom



--


type DecimalPlaces
    = DecimalPlaces Int


intToDecimalPlaces : Int -> Maybe DecimalPlaces
intToDecimalPlaces a =
    if a >= 0 && a < 100 then
        Just (DecimalPlaces a)

    else
        Nothing


decimalPlacesToInt : DecimalPlaces -> Int
decimalPlacesToInt (DecimalPlaces a) =
    a


decimalPlacesCodec : Codec.Codec DecimalPlaces
decimalPlacesCodec =
    Codec.int
        |> Codec.andThen
            (\x ->
                case intToDecimalPlaces x of
                    Just x2 ->
                        Codec.succeed x2

                    Nothing ->
                        Codec.fail "Cannot decode decimal places."
            )
            decimalPlacesToInt

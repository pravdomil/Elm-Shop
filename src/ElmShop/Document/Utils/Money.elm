module ElmShop.Document.Utils.Money exposing (DecimalPlaces, Money, codec, decimalPlacesCodec, decimalPlacesSchema, decimalPlacesToInt, fromInt, intToDecimalPlaces, schema, toInt)

import Codec
import Dataman.Schema
import Dataman.Schema.Basics


type Money
    = Money Int


fromInt : Int -> Money
fromInt =
    Money


toInt : Money -> Int
toInt (Money a) =
    a



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



--


decimalPlacesCodec : Codec.Codec DecimalPlaces
decimalPlacesCodec =
    Codec.custom
        (\fn1 x ->
            case x of
                DecimalPlaces x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "DecimalPlaces"
            DecimalPlaces
            (Codec.int
                |> Codec.andThen
                    identity
                    (\x ->
                        case intToDecimalPlaces x of
                            Just x2 ->
                                Codec.succeed (decimalPlacesToInt x2)

                            Nothing ->
                                Codec.fail "Cannot decode decimal places."
                    )
            )
        |> Codec.buildCustom


codec : Codec.Codec Money
codec =
    Codec.lazy
        (\() ->
            Codec.custom
                (\fn1 x ->
                    case x of
                        Money x1 ->
                            fn1 x1
                )
                |> Codec.variant1 "Money" Money Codec.int
                |> Codec.buildCustom
        )


schema : Dataman.Schema.Schema Money
schema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Utils", "Money" ] "Money")
        Nothing
        (Dataman.Schema.Variant "Money" [ Dataman.Schema.toAny Dataman.Schema.Basics.int ])
        []


decimalPlacesSchema : Dataman.Schema.Schema DecimalPlaces
decimalPlacesSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Utils", "Money" ] "DecimalPlaces")
        Nothing
        (Dataman.Schema.Variant "DecimalPlaces" [ Dataman.Schema.toAny Dataman.Schema.Basics.int ])
        []

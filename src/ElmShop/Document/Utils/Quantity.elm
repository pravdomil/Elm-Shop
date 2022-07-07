module ElmShop.Document.Utils.Quantity exposing (Quantity, codec, fromInt, schema, toInt)

import Codec
import Dataman.Schema
import Dataman.Schema.Basics


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
    Codec.custom
        (\fn1 x ->
            case x of
                Quantity x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "Quantity"
            Quantity
            (Codec.int
                |> Codec.andThen
                    (\x ->
                        case fromInt x of
                            Just x2 ->
                                Codec.succeed (toInt x2)

                            Nothing ->
                                Codec.fail "Cannot decode quantity."
                    )
                    identity
            )
        |> Codec.buildCustom


schema : Dataman.Schema.Schema Quantity
schema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Utils", "Quantity" ] "Quantity")
        Nothing
        [ Dataman.Schema.Variant "Quantity" [ Dataman.Schema.toAny Dataman.Schema.Basics.int ]
        ]

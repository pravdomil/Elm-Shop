module ElmShop.Document.Utils.AttributeValue exposing (..)

import Codec
import ElmShop.Document.Type
import Reference


type AttributeValue
    = StringValue { value : String }
    | AttributeValue { value : Reference.Reference ElmShop.Document.Type.Attribute }


codec : Codec.Codec AttributeValue
codec =
    Codec.custom
        (\fn1 fn2 x ->
            case x of
                StringValue x1 ->
                    fn1 x1

                AttributeValue x1 ->
                    fn2 x1
        )
        |> Codec.variant1 "StringValue"
            StringValue
            (Codec.object (\x1 -> { value = x1 })
                |> Codec.field "value" .value Codec.string
                |> Codec.buildObject
            )
        |> Codec.variant1 "AttributeValue"
            AttributeValue
            (Codec.object (\x1 -> { value = x1 })
                |> Codec.field "value" .value Reference.codec
                |> Codec.buildObject
            )
        |> Codec.buildCustom

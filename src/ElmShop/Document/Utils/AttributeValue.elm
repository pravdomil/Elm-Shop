module ElmShop.Document.Utils.AttributeValue exposing (..)

import Codec
import Dataman.Schema
import Dataman.Schema.Basics
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


schema : Dataman.Schema.Schema AttributeValue
schema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Utils", "AttributeValue" ] "AttributeValue")
        Nothing
        (Dataman.Schema.Variant "StringValue"
            [ Dataman.Schema.toAny
                (Dataman.Schema.Record Nothing
                    Nothing
                    [ Dataman.Schema.RecordField "value" (Dataman.Schema.toAny Dataman.Schema.Basics.string)
                    ]
                )
            ]
        )
        [ Dataman.Schema.Variant "AttributeValue"
            [ Dataman.Schema.toAny
                (Dataman.Schema.Record Nothing
                    Nothing
                    [ Dataman.Schema.RecordField "value" (Dataman.Schema.toAny (Dataman.Schema.Basics.reference ElmShop.Document.Type.attributeSchema))
                    ]
                )
            ]
        ]

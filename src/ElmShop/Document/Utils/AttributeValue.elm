module ElmShop.Document.Utils.AttributeValue exposing (..)

import Codec
import Dataman.Type
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
        |> Codec.variant1
            StringValue
            (Codec.record (\x1 -> { value = x1 })
                |> Codec.field .value Codec.string
                |> Codec.buildRecord
            )
        |> Codec.variant1
            AttributeValue
            (Codec.record (\x1 -> { value = x1 })
                |> Codec.field .value Reference.codec
                |> Codec.buildRecord
            )
        |> Codec.buildCustom


type_ : Dataman.Type.Type AttributeValue
type_ =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Utils", "AttributeValue" ] "AttributeValue"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "StringValue"
              , arguments =
                    [ Dataman.Type.toAny
                        (Dataman.Type.Record_
                            { name = Nothing
                            , documentation = Nothing
                            , fields =
                                [ { name = Dataman.Type.FieldName "value", type_ = Dataman.Type.toAny Dataman.Type.string }
                                ]
                            }
                        )
                    ]
              }
            , [ { name = Dataman.Type.VariantName "AttributeValue"
                , arguments =
                    [ Dataman.Type.toAny
                        (Dataman.Type.Record_
                            { name = Nothing
                            , documentation = Nothing
                            , fields =
                                [ { name = Dataman.Type.FieldName "value", type_ = Dataman.Type.toAny (Dataman.Type.reference ElmShop.Document.Type.attributeType) }
                                ]
                            }
                        )
                    ]
                }
              ]
            )
        }

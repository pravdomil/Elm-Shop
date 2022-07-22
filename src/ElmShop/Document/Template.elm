module ElmShop.Document.Template exposing (..)

import Codec
import Dataman.Type
import Dict.Any
import Dict.Any.Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.Html
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Name
import Reference


type alias Template =
    { name : ElmShop.Document.Utils.Name.Name
    , content : Content

    --
    , meta : ElmShop.Document.Utils.Meta.Meta
    }



--


type Content
    = Universal { content : ElmShop.Document.Utils.Html.Html }
    | Localized (Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Language) { content : ElmShop.Document.Utils.Html.Html })



--


codec : Codec.Codec Template
codec =
    Codec.record (\x1 x2 x3 -> { name = x1, content = x2, meta = x3 })
        |> Codec.field .name ElmShop.Document.Utils.Name.codec
        |> Codec.field .content contentCodec
        |> Codec.field .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.buildRecord


contentCodec : Codec.Codec Content
contentCodec =
    Codec.lazy
        (\() ->
            Codec.custom
                (\fn1 fn2 x ->
                    case x of
                        Universal x1 ->
                            fn1 x1

                        Localized x1 ->
                            fn2 x1
                )
                |> Codec.variant1 Universal
                    (Codec.record (\x1 -> { content = x1 })
                        |> Codec.field .content ElmShop.Document.Utils.Html.codec
                        |> Codec.buildRecord
                    )
                |> Codec.variant1 Localized
                    (Dict.Any.Codec.dict Reference.toString
                        Reference.codec
                        (Codec.record (\x1 -> { content = x1 })
                            |> Codec.field .content ElmShop.Document.Utils.Html.codec
                            |> Codec.buildRecord
                        )
                    )
                |> Codec.buildCustom
        )


type_ : Dataman.Type.Type Template
type_ =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Template" ] "Template")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "name", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Name.type_ }
            , { name = Dataman.Type.FieldName "content", type_ = Dataman.Type.toAny contentType }
            , { name = Dataman.Type.FieldName "meta", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Meta.type_ }
            ]
        }


contentType : Dataman.Type.Type Content
contentType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Template" ] "Content"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Universal"
              , arguments =
                    [ Dataman.Type.toAny
                        (Dataman.Type.Record_
                            { name = Nothing
                            , documentation = Nothing
                            , fields =
                                [ { name = Dataman.Type.FieldName "content", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Html.type_ }
                                ]
                            }
                        )
                    ]
              }
            , [ { name = Dataman.Type.VariantName "Localized"
                , arguments =
                    [ Dataman.Type.toAny
                        ((\x x2 -> Dataman.Type.AnyDict (Dataman.Type.toAny x) (Dataman.Type.toAny x2) |> Dataman.Type.Opaque_) ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.languageType)
                            (Dataman.Type.Record_
                                { name = Nothing
                                , documentation = Nothing
                                , fields =
                                    [ { name = Dataman.Type.FieldName "content", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Html.type_ }
                                    ]
                                }
                            )
                        )
                    ]
                }
              ]
            )
        }

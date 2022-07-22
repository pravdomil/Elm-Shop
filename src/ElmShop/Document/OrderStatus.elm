module ElmShop.Document.OrderStatus exposing (..)

import Codec
import Dataman.Type
import Dict.Any
import Dict.Any.Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.Html
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Name
import Reference


type alias OrderStatus =
    { translations : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Language) Translation
    , stock : Stock

    --
    , meta : ElmShop.Document.Utils.Meta.Meta
    }



--


type alias Translation =
    { name : ElmShop.Document.Utils.Name.Name
    , content : ElmShop.Document.Utils.Html.Html
    }



--


type Stock
    = NoChange
    | Reserve
    | Subtract



--


codec : Codec.Codec OrderStatus
codec =
    Codec.record (\x1 x2 x3 -> { translations = x1, stock = x2, meta = x3 })
        |> Codec.field .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field .stock stockCodec
        |> Codec.field .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.buildRecord


stockCodec : Codec.Codec Stock
stockCodec =
    Codec.lazy
        (\() ->
            Codec.custom
                (\fn1 fn2 fn3 x ->
                    case x of
                        NoChange ->
                            fn1

                        Reserve ->
                            fn2

                        Subtract ->
                            fn3
                )
                |> Codec.variant0 NoChange
                |> Codec.variant0 Reserve
                |> Codec.variant0 Subtract
                |> Codec.buildCustom
        )


translationCodec : Codec.Codec Translation
translationCodec =
    Codec.record (\x1 x2 -> { name = x1, content = x2 })
        |> Codec.field .name ElmShop.Document.Utils.Name.codec
        |> Codec.field .content ElmShop.Document.Utils.Html.codec
        |> Codec.buildRecord


type_ : Dataman.Type.Type OrderStatus
type_ =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "OrderStatus" ] "OrderStatus")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "translations", type_ = Dataman.Type.toAny ((\x x2 -> Dataman.Type.AnyDict (Dataman.Type.toAny x) (Dataman.Type.toAny x2) |> Dataman.Type.Opaque_) ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.languageType) translationType) }
            , { name = Dataman.Type.FieldName "stock", type_ = Dataman.Type.toAny stockType }
            , { name = Dataman.Type.FieldName "meta", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Meta.type_ }
            ]
        }


translationType : Dataman.Type.Type Translation
translationType =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "OrderStatus" ] "Translation")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "name", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Name.type_ }
            , { name = Dataman.Type.FieldName "content", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Html.type_ }
            ]
        }


stockType : Dataman.Type.Type Stock
stockType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "OrderStatus" ] "Stock"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "NoChange", arguments = [] }
            , [ { name = Dataman.Type.VariantName "Reserve", arguments = [] }
              , { name = Dataman.Type.VariantName "Subtract", arguments = [] }
              ]
            )
        }

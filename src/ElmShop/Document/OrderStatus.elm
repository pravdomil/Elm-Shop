module ElmShop.Document.OrderStatus exposing (..)

import Codec
import Dataman.Schema
import Dataman.Schema.Basics
import Dict.Any
import Dict.Any.Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.Html
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Name
import Id
import Reference


type alias OrderStatus =
    { id : Id.Id ElmShop.Document.Type.OrderStatus
    , meta : ElmShop.Document.Utils.Meta.Meta

    --
    , translations : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Language) Translation
    , stock : Stock
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
    Codec.record (\x1 x2 x3 x4 -> { id = x1, meta = x2, translations = x3, stock = x4 })
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "translations" .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field "stock" .stock stockCodec
        |> Codec.buildRecord


stockCodec : Codec.Codec Stock
stockCodec =
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
        |> Codec.variant0 "NoChange" NoChange
        |> Codec.variant0 "Reserve" Reserve
        |> Codec.variant0 "Subtract" Subtract
        |> Codec.buildCustom


translationCodec : Codec.Codec Translation
translationCodec =
    Codec.record (\x1 x2 -> { name = x1, content = x2 })
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "content" .content ElmShop.Document.Utils.Html.codec
        |> Codec.buildRecord


schema : Dataman.Schema.Schema OrderStatus
schema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "OrderStatus" ] "OrderStatus"))
        Nothing
        [ Dataman.Schema.RecordField "id" (Dataman.Schema.toAny (Dataman.Schema.Basics.id ElmShop.Document.Type.orderStatusSchema))
        , Dataman.Schema.RecordField "meta" (Dataman.Schema.toAny ElmShop.Document.Utils.Meta.schema)
        , Dataman.Schema.RecordField "translations" (Dataman.Schema.toAny (Dataman.Schema.Basics.anyDict (Dataman.Schema.Basics.reference ElmShop.Document.Type.languageSchema) translationSchema))
        , Dataman.Schema.RecordField "stock" (Dataman.Schema.toAny stockSchema)
        ]


translationSchema : Dataman.Schema.Schema Translation
translationSchema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "OrderStatus" ] "Translation"))
        Nothing
        [ Dataman.Schema.RecordField "name" (Dataman.Schema.toAny ElmShop.Document.Utils.Name.schema)
        , Dataman.Schema.RecordField "content" (Dataman.Schema.toAny ElmShop.Document.Utils.Html.schema)
        ]


stockSchema : Dataman.Schema.Schema Stock
stockSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "OrderStatus" ] "Stock")
        Nothing
        (Dataman.Schema.Variant "NoChange" [])
        [ Dataman.Schema.Variant "Reserve" []
        , Dataman.Schema.Variant "Subtract" []
        ]

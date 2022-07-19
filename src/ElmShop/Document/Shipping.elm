module ElmShop.Document.Shipping exposing (..)

import Codec
import Dataman.Schema
import Dataman.Schema.Basics
import Dict.Any
import Dict.Any.Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.CountryFilter
import ElmShop.Document.Utils.Html
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Money
import ElmShop.Document.Utils.Name
import Id
import Reference


type alias Shipping =
    { id : Id.Id ElmShop.Document.Type.Shipping
    , meta : ElmShop.Document.Utils.Meta.Meta

    --
    , translations : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Language) Translation
    , type_ : Type
    }



--


type alias Translation =
    { name : ElmShop.Document.Utils.Name.Name
    , content : ElmShop.Document.Utils.Html.Html
    }



--


type Type
    = Basic_ Basic



--


type alias Basic =
    { price : ElmShop.Document.Utils.Money.Money
    , minTotal : Maybe ElmShop.Document.Utils.Money.Money
    , maxTotal : Maybe ElmShop.Document.Utils.Money.Money

    --
    , filter : Maybe ElmShop.Document.Utils.CountryFilter.CountryFilter
    }



--


codec : Codec.Codec Shipping
codec =
    Codec.record (\x1 x2 x3 x4 -> { id = x1, meta = x2, translations = x3, type_ = x4 })
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "translations" .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field "type_" .type_ typeCodec
        |> Codec.buildRecord


basicCodec : Codec.Codec Basic
basicCodec =
    Codec.record (\x1 x2 x3 x4 -> { price = x1, minTotal = x2, maxTotal = x3, filter = x4 })
        |> Codec.field "price" .price ElmShop.Document.Utils.Money.codec
        |> Codec.field "minTotal" .minTotal (Codec.maybe ElmShop.Document.Utils.Money.codec)
        |> Codec.field "maxTotal" .maxTotal (Codec.maybe ElmShop.Document.Utils.Money.codec)
        |> Codec.field "filter" .filter (Codec.maybe ElmShop.Document.Utils.CountryFilter.codec)
        |> Codec.buildRecord


typeCodec : Codec.Codec Type
typeCodec =
    Codec.custom
        (\fn1 x ->
            case x of
                Basic_ x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "Basic_" Basic_ basicCodec
        |> Codec.buildCustom


translationCodec : Codec.Codec Translation
translationCodec =
    Codec.record (\x1 x2 -> { name = x1, content = x2 })
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "content" .content ElmShop.Document.Utils.Html.codec
        |> Codec.buildRecord


schema : Dataman.Schema.Schema Shipping
schema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Shipping" ] "Shipping"))
        Nothing
        [ Dataman.Schema.RecordField "id" (Dataman.Schema.toAny (Dataman.Schema.Basics.id ElmShop.Document.Type.shippingSchema))
        , Dataman.Schema.RecordField "meta" (Dataman.Schema.toAny ElmShop.Document.Utils.Meta.schema)
        , Dataman.Schema.RecordField "translations" (Dataman.Schema.toAny (Dataman.Schema.Basics.anyDict (Dataman.Schema.Basics.reference ElmShop.Document.Type.languageSchema) translationSchema))
        , Dataman.Schema.RecordField "type_" (Dataman.Schema.toAny typeSchema)
        ]


translationSchema : Dataman.Schema.Schema Translation
translationSchema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Shipping" ] "Translation"))
        Nothing
        [ Dataman.Schema.RecordField "name" (Dataman.Schema.toAny ElmShop.Document.Utils.Name.schema)
        , Dataman.Schema.RecordField "content" (Dataman.Schema.toAny ElmShop.Document.Utils.Html.schema)
        ]


typeSchema : Dataman.Schema.Schema Type
typeSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Shipping" ] "Type")
        Nothing
        (Dataman.Schema.Variant "Basic_" [ Dataman.Schema.toAny basicSchema ])
        []


basicSchema : Dataman.Schema.Schema Basic
basicSchema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Shipping" ] "Basic"))
        Nothing
        [ Dataman.Schema.RecordField "price" (Dataman.Schema.toAny ElmShop.Document.Utils.Money.schema)
        , Dataman.Schema.RecordField "minTotal" (Dataman.Schema.toAny (Dataman.Schema.Basics.maybe ElmShop.Document.Utils.Money.schema))
        , Dataman.Schema.RecordField "maxTotal" (Dataman.Schema.toAny (Dataman.Schema.Basics.maybe ElmShop.Document.Utils.Money.schema))
        , Dataman.Schema.RecordField "filter" (Dataman.Schema.toAny (Dataman.Schema.Basics.maybe ElmShop.Document.Utils.CountryFilter.schema))
        ]

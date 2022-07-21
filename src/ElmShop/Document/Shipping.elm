module ElmShop.Document.Shipping exposing (..)

import Codec
import Dataman.Type
import Dict.Any
import Dict.Any.Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.CountryFilter
import ElmShop.Document.Utils.Html
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Money
import ElmShop.Document.Utils.Name
import Reference


type alias Shipping =
    { translations : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Language) Translation
    , type_ : Type

    --
    , meta : ElmShop.Document.Utils.Meta.Meta
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
    Codec.record (\x1 x2 x3 -> { translations = x1, type_ = x2, meta = x3 })
        |> Codec.field "translations" .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field "type_" .type_ typeCodec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
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
    Codec.lazy
        (\() ->
            Codec.custom
                (\fn1 x ->
                    case x of
                        Basic_ x1 ->
                            fn1 x1
                )
                |> Codec.variant1 "Basic_" Basic_ basicCodec
                |> Codec.buildCustom
        )


translationCodec : Codec.Codec Translation
translationCodec =
    Codec.record (\x1 x2 -> { name = x1, content = x2 })
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "content" .content ElmShop.Document.Utils.Html.codec
        |> Codec.buildRecord


type_ : Dataman.Type.Type Shipping
type_ =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Shipping" ] "Shipping")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "translations", type_ = Dataman.Type.toAny ((\x x2 -> Dataman.Type.AnyDict (Dataman.Type.toAny x) (Dataman.Type.toAny x2) |> Dataman.Type.Opaque_) ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.languageType) translationType) }
            , { name = Dataman.Type.FieldName "type_", type_ = Dataman.Type.toAny typeType }
            , { name = Dataman.Type.FieldName "meta", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Meta.type_ }
            ]
        }


translationType : Dataman.Type.Type Translation
translationType =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Shipping" ] "Translation")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "name", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Name.type_ }
            , { name = Dataman.Type.FieldName "content", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Html.type_ }
            ]
        }


typeType : Dataman.Type.Type Type
typeType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Shipping" ] "Type"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Basic_", arguments = [ Dataman.Type.toAny basicType ] }
            , []
            )
        }


basicType : Dataman.Type.Type Basic
basicType =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Shipping" ] "Basic")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "price", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Money.type_ }
            , { name = Dataman.Type.FieldName "minTotal", type_ = Dataman.Type.toAny (Dataman.Type.maybe ElmShop.Document.Utils.Money.type_) }
            , { name = Dataman.Type.FieldName "maxTotal", type_ = Dataman.Type.toAny (Dataman.Type.maybe ElmShop.Document.Utils.Money.type_) }
            , { name = Dataman.Type.FieldName "filter", type_ = Dataman.Type.toAny (Dataman.Type.maybe ElmShop.Document.Utils.CountryFilter.type_) }
            ]
        }

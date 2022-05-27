module ElmShop.Document.Shipping exposing (..)

import Codec
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


codec : Codec.Codec Shipping
codec =
    Codec.object Shipping
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "translations" .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field "type_" .type_ typeCodec
        |> Codec.buildObject



--


type alias Translation =
    { name : ElmShop.Document.Utils.Name.Name
    , content : ElmShop.Document.Utils.Html.Html
    }


translationCodec : Codec.Codec Translation
translationCodec =
    Codec.object Translation
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "content" .content ElmShop.Document.Utils.Html.codec
        |> Codec.buildObject



--


type Type
    = Basic_ Basic


typeCodec : Codec.Codec Type
typeCodec =
    Codec.custom
        (\fn1 v ->
            case v of
                Basic_ v1 ->
                    fn1 v1
        )
        |> Codec.variant1 "Basic_" Basic_ basicCodec
        |> Codec.buildCustom



--


type alias Basic =
    { price : ElmShop.Document.Utils.Money.Money
    , minTotal : Maybe ElmShop.Document.Utils.Money.Money
    , maxTotal : Maybe ElmShop.Document.Utils.Money.Money

    --
    , filter : Maybe ElmShop.Document.Utils.CountryFilter.CountryFilter
    }


basicCodec : Codec.Codec Basic
basicCodec =
    Codec.object Basic
        |> Codec.field "price" .price ElmShop.Document.Utils.Money.codec
        |> Codec.field "minTotal" .minTotal (Codec.maybe ElmShop.Document.Utils.Money.codec)
        |> Codec.field "maxTotal" .maxTotal (Codec.maybe ElmShop.Document.Utils.Money.codec)
        |> Codec.field "filter" .filter (Codec.maybe ElmShop.Document.Utils.CountryFilter.codec)
        |> Codec.buildObject

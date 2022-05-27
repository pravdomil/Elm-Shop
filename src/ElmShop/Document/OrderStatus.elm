module ElmShop.Document.OrderStatus exposing (..)

import Codec
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


codec : Codec.Codec OrderStatus
codec =
    Codec.object OrderStatus
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "translations" .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field "stock" .stock stockCodec
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


type Stock
    = NoChange
    | Reserve
    | Subtract


stockCodec : Codec.Codec Stock
stockCodec =
    Codec.custom
        (\fn1 fn2 fn3 v ->
            case v of
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

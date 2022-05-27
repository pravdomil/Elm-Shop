module ElmShop.Document.Review exposing (..)

import Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Text
import Id
import Reference


type alias Review =
    { id : Id.Id ElmShop.Document.Type.Review
    , meta : ElmShop.Document.Utils.Meta.Meta

    --
    , order : Reference.Reference ElmShop.Document.Type.Order
    , product : Reference.Reference ElmShop.Document.Type.Product
    , content : ElmShop.Document.Utils.Text.Text
    , rating : Rating
    }


codec : Codec.Codec Review
codec =
    Codec.object Review
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "order" .order Reference.codec
        |> Codec.field "product" .product Reference.codec
        |> Codec.field "content" .content ElmShop.Document.Utils.Text.codec
        |> Codec.field "rating" .rating ratingCodec
        |> Codec.buildObject



--


type Rating
    = Rating Int


ratingCodec : Codec.Codec Rating
ratingCodec =
    Codec.custom
        (\fn1 v ->
            case v of
                Rating v1 ->
                    fn1 v1
        )
        |> Codec.variant1 "Rating" Rating Codec.int
        |> Codec.buildCustom

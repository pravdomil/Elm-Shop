module ElmShop.Document.Review exposing (..)

import Codec
import Dataman.Type
import ElmShop.Document.Type
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Text
import Reference


type alias Review =
    { order : Reference.Reference ElmShop.Document.Type.Order
    , product : Reference.Reference ElmShop.Document.Type.Product
    , content : ElmShop.Document.Utils.Text.Text
    , rating : Rating

    --
    , meta : ElmShop.Document.Utils.Meta.Meta
    }



--


type Rating
    = Rating Int



--


codec : Codec.Codec Review
codec =
    Codec.record (\x1 x2 x3 x4 x5 -> { order = x1, product = x2, content = x3, rating = x4, meta = x5 })
        |> Codec.field "order" .order Reference.codec
        |> Codec.field "product" .product Reference.codec
        |> Codec.field "content" .content ElmShop.Document.Utils.Text.codec
        |> Codec.field "rating" .rating ratingCodec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.buildRecord


ratingCodec : Codec.Codec Rating
ratingCodec =
    Codec.lazy
        (\() ->
            Codec.custom
                (\fn1 x ->
                    case x of
                        Rating x1 ->
                            fn1 x1
                )
                |> Codec.variant1 "Rating" Rating Codec.int
                |> Codec.buildCustom
        )


type_ : Dataman.Type.Type Review
type_ =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Review" ] "Review")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "order", type_ = Dataman.Type.toAny ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.orderType) }
            , { name = Dataman.Type.FieldName "product", type_ = Dataman.Type.toAny ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.productType) }
            , { name = Dataman.Type.FieldName "content", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Text.type_ }
            , { name = Dataman.Type.FieldName "rating", type_ = Dataman.Type.toAny ratingType }
            , { name = Dataman.Type.FieldName "meta", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Meta.type_ }
            ]
        }


ratingType : Dataman.Type.Type Rating
ratingType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Review" ] "Rating"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Rating", arguments = [ Dataman.Type.toAny (Dataman.Type.Int_ |> Dataman.Type.Opaque_) ] }
            , []
            )
        }

module ElmShop.Document.Review exposing (..)

import Codec
import Dataman.Schema
import Dataman.Schema.Basics
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


schema : Dataman.Schema.Schema Review
schema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Review" ] "Review"))
        Nothing
        [ Dataman.Schema.RecordField "order" (Dataman.Schema.toAny (Dataman.Schema.Basics.reference ElmShop.Document.Type.orderSchema))
        , Dataman.Schema.RecordField "product" (Dataman.Schema.toAny (Dataman.Schema.Basics.reference ElmShop.Document.Type.productSchema))
        , Dataman.Schema.RecordField "content" (Dataman.Schema.toAny ElmShop.Document.Utils.Text.schema)
        , Dataman.Schema.RecordField "rating" (Dataman.Schema.toAny ratingSchema)
        , Dataman.Schema.RecordField "meta" (Dataman.Schema.toAny ElmShop.Document.Utils.Meta.schema)
        ]


ratingSchema : Dataman.Schema.Schema Rating
ratingSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Review" ] "Rating")
        Nothing
        (Dataman.Schema.Variant "Rating" [ Dataman.Schema.toAny Dataman.Schema.Basics.int ])
        []

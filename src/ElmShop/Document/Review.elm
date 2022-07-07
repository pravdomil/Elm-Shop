module ElmShop.Document.Review exposing (..)

import Codec
import Dataman.Schema
import Dataman.Schema.Basics
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



--


type Rating
    = Rating Int



--


codec : Codec.Codec Review
codec =
    Codec.object (\x1 x2 x3 x4 x5 x6 -> { id = x1, meta = x2, order = x3, product = x4, content = x5, rating = x6 })
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "order" .order Reference.codec
        |> Codec.field "product" .product Reference.codec
        |> Codec.field "content" .content ElmShop.Document.Utils.Text.codec
        |> Codec.field "rating" .rating ratingCodec
        |> Codec.buildObject


ratingCodec : Codec.Codec Rating
ratingCodec =
    Codec.custom
        (\fn1 x ->
            case x of
                Rating x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "Rating" Rating Codec.int
        |> Codec.buildCustom


schema : Dataman.Schema.Schema Review
schema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Review" ] "Review"))
        Nothing
        [ Dataman.Schema.RecordField "id" (Dataman.Schema.toAny (Dataman.Schema.Basics.id ElmShop.Document.Type.reviewSchema))
        , Dataman.Schema.RecordField "meta" (Dataman.Schema.toAny ElmShop.Document.Utils.Meta.schema)
        , Dataman.Schema.RecordField "order" (Dataman.Schema.toAny (Dataman.Schema.Basics.reference ElmShop.Document.Type.orderSchema))
        , Dataman.Schema.RecordField "product" (Dataman.Schema.toAny (Dataman.Schema.Basics.reference ElmShop.Document.Type.productSchema))
        , Dataman.Schema.RecordField "content" (Dataman.Schema.toAny ElmShop.Document.Utils.Text.schema)
        , Dataman.Schema.RecordField "rating" (Dataman.Schema.toAny ratingSchema)
        ]


ratingSchema : Dataman.Schema.Schema Rating
ratingSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Review" ] "Rating")
        Nothing
        [ Dataman.Schema.Variant "Rating" [ Dataman.Schema.toAny Dataman.Schema.Basics.int ]
        ]

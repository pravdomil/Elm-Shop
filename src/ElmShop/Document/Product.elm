module ElmShop.Document.Product exposing (..)

import Codec
import Codec.Extra
import Dataman.Schema
import Dataman.Schema.Basics
import Dict.Any
import Dict.Any.Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.AttributeValue
import ElmShop.Document.Utils.Html
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Money
import ElmShop.Document.Utils.Name
import ElmShop.Document.Utils.Order
import ElmShop.Document.Utils.Quantity
import Id
import Reference


type alias Product =
    { id : Id.Id ElmShop.Document.Type.Product
    , meta : ElmShop.Document.Utils.Meta.Meta

    --
    , type_ : Type
    , sale : Sale

    --
    , translations : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Language) Translation
    , sku : Maybe Sku
    , stock : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Warehouse) { quantity : StockQuantity }
    , reservations : Reservations

    --
    , image : Maybe (Reference.Reference ElmShop.Document.Type.File)
    , gallery : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.File) { order : ElmShop.Document.Utils.Order.Order }

    --
    , attributes : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Attribute) ElmShop.Document.Utils.AttributeValue.AttributeValue

    --
    , related : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Product) ()
    , categories : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Category) ()
    }



--


type Type
    = Single_ Single
    | Variable_ Variable
    | Set_ Set



--


type alias Single =
    { price : ElmShop.Document.Utils.Money.Money
    }



--


type alias Variable =
    { products : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Product) ()
    }



--


type alias Set =
    { products : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Product) { quantity : ElmShop.Document.Utils.Quantity.Quantity }
    , price : ElmShop.Document.Utils.Money.Money
    }



--


type Sale
    = ForSale
    | NotForSale



--


type alias Translation =
    { name : ElmShop.Document.Utils.Name.Name
    , content : ElmShop.Document.Utils.Html.Html
    }



--


type Sku
    = Sku String



--


type Reservations
    = Reservations Int



--


type StockQuantity
    = StockQuantity Int



--


codec : Codec.Codec Product
codec =
    Codec.object (\x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 -> { id = x1, meta = x2, type_ = x3, sale = x4, translations = x5, sku = x6, stock = x7, reservations = x8, image = x9, gallery = x10, attributes = x11, related = x12, categories = x13 })
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "type_" .type_ typeCodec
        |> Codec.field "sale" .sale saleCodec
        |> Codec.field "translations" .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field "sku" .sku (Codec.Extra.maybe skuCodec)
        |> Codec.field "stock"
            .stock
            (Dict.Any.Codec.dict Reference.toString
                Reference.codec
                (Codec.object (\x1 -> { quantity = x1 })
                    |> Codec.field "quantity" .quantity stockQuantityCodec
                    |> Codec.buildObject
                )
            )
        |> Codec.field "reservations" .reservations reservationsCodec
        |> Codec.field "image" .image (Codec.Extra.maybe Reference.codec)
        |> Codec.field "gallery"
            .gallery
            (Dict.Any.Codec.dict Reference.toString
                Reference.codec
                (Codec.object (\x1 -> { order = x1 })
                    |> Codec.field "order" .order ElmShop.Document.Utils.Order.codec
                    |> Codec.buildObject
                )
            )
        |> Codec.field "attributes" .attributes (Dict.Any.Codec.dict Reference.toString Reference.codec ElmShop.Document.Utils.AttributeValue.codec)
        |> Codec.field "related" .related (Dict.Any.Codec.dict Reference.toString Reference.codec (Codec.succeed ()))
        |> Codec.field "categories" .categories (Dict.Any.Codec.dict Reference.toString Reference.codec (Codec.succeed ()))
        |> Codec.buildObject


reservationsCodec : Codec.Codec Reservations
reservationsCodec =
    Codec.custom
        (\fn1 x ->
            case x of
                Reservations x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "Reservations" Reservations Codec.int
        |> Codec.buildCustom


stockQuantityCodec : Codec.Codec StockQuantity
stockQuantityCodec =
    Codec.custom
        (\fn1 x ->
            case x of
                StockQuantity x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "StockQuantity" StockQuantity Codec.int
        |> Codec.buildCustom


skuCodec : Codec.Codec Sku
skuCodec =
    Codec.custom
        (\fn1 x ->
            case x of
                Sku x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "Sku" Sku Codec.string
        |> Codec.buildCustom


translationCodec : Codec.Codec Translation
translationCodec =
    Codec.object (\x1 x2 -> { name = x1, content = x2 })
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "content" .content ElmShop.Document.Utils.Html.codec
        |> Codec.buildObject


saleCodec : Codec.Codec Sale
saleCodec =
    Codec.custom
        (\fn1 fn2 x ->
            case x of
                ForSale ->
                    fn1

                NotForSale ->
                    fn2
        )
        |> Codec.variant0 "ForSale" ForSale
        |> Codec.variant0 "NotForSale" NotForSale
        |> Codec.buildCustom


setCodec : Codec.Codec Set
setCodec =
    Codec.object (\x1 x2 -> { products = x1, price = x2 })
        |> Codec.field "products"
            .products
            (Dict.Any.Codec.dict Reference.toString
                Reference.codec
                (Codec.object (\x1 -> { quantity = x1 })
                    |> Codec.field "quantity" .quantity ElmShop.Document.Utils.Quantity.codec
                    |> Codec.buildObject
                )
            )
        |> Codec.field "price" .price ElmShop.Document.Utils.Money.codec
        |> Codec.buildObject


variableCodec : Codec.Codec Variable
variableCodec =
    Codec.object (\x1 -> { products = x1 })
        |> Codec.field "products" .products (Dict.Any.Codec.dict Reference.toString Reference.codec (Codec.succeed ()))
        |> Codec.buildObject


singleCodec : Codec.Codec Single
singleCodec =
    Codec.object (\x1 -> { price = x1 })
        |> Codec.field "price" .price ElmShop.Document.Utils.Money.codec
        |> Codec.buildObject


typeCodec : Codec.Codec Type
typeCodec =
    Codec.custom
        (\fn1 fn2 fn3 x ->
            case x of
                Single_ x1 ->
                    fn1 x1

                Variable_ x1 ->
                    fn2 x1

                Set_ x1 ->
                    fn3 x1
        )
        |> Codec.variant1 "Single_" Single_ singleCodec
        |> Codec.variant1 "Variable_" Variable_ variableCodec
        |> Codec.variant1 "Set_" Set_ setCodec
        |> Codec.buildCustom


schema : Dataman.Schema.Schema Product
schema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Product" ] "Product"))
        Nothing
        [ Dataman.Schema.RecordField "id" (Dataman.Schema.toAny (Dataman.Schema.Basics.id ElmShop.Document.Type.productSchema))
        , Dataman.Schema.RecordField "meta" (Dataman.Schema.toAny ElmShop.Document.Utils.Meta.schema)
        , Dataman.Schema.RecordField "type_" (Dataman.Schema.toAny typeSchema)
        , Dataman.Schema.RecordField "sale" (Dataman.Schema.toAny saleSchema)
        , Dataman.Schema.RecordField "translations" (Dataman.Schema.toAny (Dataman.Schema.Basics.anyDict (Dataman.Schema.Basics.reference ElmShop.Document.Type.languageSchema) translationSchema))
        , Dataman.Schema.RecordField "sku" (Dataman.Schema.toAny (Dataman.Schema.Basics.maybe skuSchema))
        , Dataman.Schema.RecordField "stock"
            (Dataman.Schema.toAny
                (Dataman.Schema.Basics.anyDict (Dataman.Schema.Basics.reference ElmShop.Document.Type.warehouseSchema)
                    (Dataman.Schema.Record Nothing
                        Nothing
                        [ Dataman.Schema.RecordField "quantity" (Dataman.Schema.toAny stockQuantitySchema)
                        ]
                    )
                )
            )
        , Dataman.Schema.RecordField "reservations" (Dataman.Schema.toAny reservationsSchema)
        , Dataman.Schema.RecordField "image" (Dataman.Schema.toAny (Dataman.Schema.Basics.maybe (Dataman.Schema.Basics.reference ElmShop.Document.Type.fileSchema)))
        , Dataman.Schema.RecordField "gallery"
            (Dataman.Schema.toAny
                (Dataman.Schema.Basics.anyDict (Dataman.Schema.Basics.reference ElmShop.Document.Type.fileSchema)
                    (Dataman.Schema.Record Nothing
                        Nothing
                        [ Dataman.Schema.RecordField "order" (Dataman.Schema.toAny ElmShop.Document.Utils.Order.schema)
                        ]
                    )
                )
            )
        , Dataman.Schema.RecordField "attributes" (Dataman.Schema.toAny (Dataman.Schema.Basics.anyDict (Dataman.Schema.Basics.reference ElmShop.Document.Type.attributeSchema) ElmShop.Document.Utils.AttributeValue.schema))
        , Dataman.Schema.RecordField "related" (Dataman.Schema.toAny (Dataman.Schema.Basics.anyDict (Dataman.Schema.Basics.reference ElmShop.Document.Type.productSchema) (Dataman.Schema.Tuple Nothing Nothing [])))
        , Dataman.Schema.RecordField "categories" (Dataman.Schema.toAny (Dataman.Schema.Basics.anyDict (Dataman.Schema.Basics.reference ElmShop.Document.Type.categorySchema) (Dataman.Schema.Tuple Nothing Nothing [])))
        ]


typeSchema : Dataman.Schema.Schema Type
typeSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Product" ] "Type")
        Nothing
        (Dataman.Schema.Variant "Single_" [ Dataman.Schema.toAny singleSchema ])
        [ Dataman.Schema.Variant "Variable_" [ Dataman.Schema.toAny variableSchema ]
        , Dataman.Schema.Variant "Set_" [ Dataman.Schema.toAny setSchema ]
        ]


singleSchema : Dataman.Schema.Schema Single
singleSchema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Product" ] "Single"))
        Nothing
        [ Dataman.Schema.RecordField "price" (Dataman.Schema.toAny ElmShop.Document.Utils.Money.schema)
        ]


variableSchema : Dataman.Schema.Schema Variable
variableSchema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Product" ] "Variable"))
        Nothing
        [ Dataman.Schema.RecordField "products" (Dataman.Schema.toAny (Dataman.Schema.Basics.anyDict (Dataman.Schema.Basics.reference ElmShop.Document.Type.productSchema) (Dataman.Schema.Tuple Nothing Nothing [])))
        ]


setSchema : Dataman.Schema.Schema Set
setSchema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Product" ] "Set"))
        Nothing
        [ Dataman.Schema.RecordField "products"
            (Dataman.Schema.toAny
                (Dataman.Schema.Basics.anyDict (Dataman.Schema.Basics.reference ElmShop.Document.Type.productSchema)
                    (Dataman.Schema.Record Nothing
                        Nothing
                        [ Dataman.Schema.RecordField "quantity" (Dataman.Schema.toAny ElmShop.Document.Utils.Quantity.schema)
                        ]
                    )
                )
            )
        , Dataman.Schema.RecordField "price" (Dataman.Schema.toAny ElmShop.Document.Utils.Money.schema)
        ]


saleSchema : Dataman.Schema.Schema Sale
saleSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Product" ] "Sale")
        Nothing
        (Dataman.Schema.Variant "ForSale" [])
        [ Dataman.Schema.Variant "NotForSale" []
        ]


translationSchema : Dataman.Schema.Schema Translation
translationSchema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Product" ] "Translation"))
        Nothing
        [ Dataman.Schema.RecordField "name" (Dataman.Schema.toAny ElmShop.Document.Utils.Name.schema)
        , Dataman.Schema.RecordField "content" (Dataman.Schema.toAny ElmShop.Document.Utils.Html.schema)
        ]


skuSchema : Dataman.Schema.Schema Sku
skuSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Product" ] "Sku")
        Nothing
        (Dataman.Schema.Variant "Sku" [ Dataman.Schema.toAny Dataman.Schema.Basics.string ])
        []


stockQuantitySchema : Dataman.Schema.Schema StockQuantity
stockQuantitySchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Product" ] "StockQuantity")
        Nothing
        (Dataman.Schema.Variant "StockQuantity" [ Dataman.Schema.toAny Dataman.Schema.Basics.int ])
        []


reservationsSchema : Dataman.Schema.Schema Reservations
reservationsSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Product" ] "Reservations")
        Nothing
        (Dataman.Schema.Variant "Reservations" [ Dataman.Schema.toAny Dataman.Schema.Basics.int ])
        []

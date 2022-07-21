module ElmShop.Document.Product exposing (..)

import Codec
import Dataman.Type
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
import Reference


type alias Product =
    { type_ : Type
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

    --
    , meta : ElmShop.Document.Utils.Meta.Meta
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
    Codec.record (\x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 -> { type_ = x1, sale = x2, translations = x3, sku = x4, stock = x5, reservations = x6, image = x7, gallery = x8, attributes = x9, related = x10, categories = x11, meta = x12 })
        |> Codec.field "type_" .type_ typeCodec
        |> Codec.field "sale" .sale saleCodec
        |> Codec.field "translations" .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field "sku" .sku (Codec.maybe skuCodec)
        |> Codec.field "stock"
            .stock
            (Dict.Any.Codec.dict Reference.toString
                Reference.codec
                (Codec.record (\x1 -> { quantity = x1 })
                    |> Codec.field "quantity" .quantity stockQuantityCodec
                    |> Codec.buildRecord
                )
            )
        |> Codec.field "reservations" .reservations reservationsCodec
        |> Codec.field "image" .image (Codec.maybe Reference.codec)
        |> Codec.field "gallery"
            .gallery
            (Dict.Any.Codec.dict Reference.toString
                Reference.codec
                (Codec.record (\x1 -> { order = x1 })
                    |> Codec.field "order" .order ElmShop.Document.Utils.Order.codec
                    |> Codec.buildRecord
                )
            )
        |> Codec.field "attributes" .attributes (Dict.Any.Codec.dict Reference.toString Reference.codec ElmShop.Document.Utils.AttributeValue.codec)
        |> Codec.field "related" .related (Dict.Any.Codec.dict Reference.toString Reference.codec (Codec.succeed ()))
        |> Codec.field "categories" .categories (Dict.Any.Codec.dict Reference.toString Reference.codec (Codec.succeed ()))
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.buildRecord


reservationsCodec : Codec.Codec Reservations
reservationsCodec =
    Codec.lazy
        (\() ->
            Codec.custom
                (\fn1 x ->
                    case x of
                        Reservations x1 ->
                            fn1 x1
                )
                |> Codec.variant1 "Reservations" Reservations Codec.int
                |> Codec.buildCustom
        )


stockQuantityCodec : Codec.Codec StockQuantity
stockQuantityCodec =
    Codec.lazy
        (\() ->
            Codec.custom
                (\fn1 x ->
                    case x of
                        StockQuantity x1 ->
                            fn1 x1
                )
                |> Codec.variant1 "StockQuantity" StockQuantity Codec.int
                |> Codec.buildCustom
        )


skuCodec : Codec.Codec Sku
skuCodec =
    Codec.lazy
        (\() ->
            Codec.custom
                (\fn1 x ->
                    case x of
                        Sku x1 ->
                            fn1 x1
                )
                |> Codec.variant1 "Sku" Sku Codec.string
                |> Codec.buildCustom
        )


translationCodec : Codec.Codec Translation
translationCodec =
    Codec.record (\x1 x2 -> { name = x1, content = x2 })
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "content" .content ElmShop.Document.Utils.Html.codec
        |> Codec.buildRecord


saleCodec : Codec.Codec Sale
saleCodec =
    Codec.lazy
        (\() ->
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
        )


setCodec : Codec.Codec Set
setCodec =
    Codec.record (\x1 x2 -> { products = x1, price = x2 })
        |> Codec.field "products"
            .products
            (Dict.Any.Codec.dict Reference.toString
                Reference.codec
                (Codec.record (\x1 -> { quantity = x1 })
                    |> Codec.field "quantity" .quantity ElmShop.Document.Utils.Quantity.codec
                    |> Codec.buildRecord
                )
            )
        |> Codec.field "price" .price ElmShop.Document.Utils.Money.codec
        |> Codec.buildRecord


variableCodec : Codec.Codec Variable
variableCodec =
    Codec.record (\x1 -> { products = x1 })
        |> Codec.field "products" .products (Dict.Any.Codec.dict Reference.toString Reference.codec (Codec.succeed ()))
        |> Codec.buildRecord


singleCodec : Codec.Codec Single
singleCodec =
    Codec.record (\x1 -> { price = x1 })
        |> Codec.field "price" .price ElmShop.Document.Utils.Money.codec
        |> Codec.buildRecord


typeCodec : Codec.Codec Type
typeCodec =
    Codec.lazy
        (\() ->
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
        )


type_ : Dataman.Type.Type Product
type_ =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Product" ] "Product")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "type_", type_ = Dataman.Type.toAny typeType }
            , { name = Dataman.Type.FieldName "sale", type_ = Dataman.Type.toAny saleType }
            , { name = Dataman.Type.FieldName "translations", type_ = Dataman.Type.toAny ((\x x2 -> Dataman.Type.AnyDict (Dataman.Type.toAny x) (Dataman.Type.toAny x2) |> Dataman.Type.Opaque_) ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.languageType) translationType) }
            , { name = Dataman.Type.FieldName "sku", type_ = Dataman.Type.toAny (Dataman.Type.maybe skuType) }
            , { name = Dataman.Type.FieldName "stock"
              , type_ =
                    Dataman.Type.toAny
                        ((\x x2 -> Dataman.Type.AnyDict (Dataman.Type.toAny x) (Dataman.Type.toAny x2) |> Dataman.Type.Opaque_) ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.warehouseType)
                            (Dataman.Type.Record_
                                { name = Nothing
                                , documentation = Nothing
                                , fields =
                                    [ { name = Dataman.Type.FieldName "quantity", type_ = Dataman.Type.toAny stockQuantityType }
                                    ]
                                }
                            )
                        )
              }
            , { name = Dataman.Type.FieldName "reservations", type_ = Dataman.Type.toAny reservationsType }
            , { name = Dataman.Type.FieldName "image", type_ = Dataman.Type.toAny (Dataman.Type.maybe ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.fileType)) }
            , { name = Dataman.Type.FieldName "gallery"
              , type_ =
                    Dataman.Type.toAny
                        ((\x x2 -> Dataman.Type.AnyDict (Dataman.Type.toAny x) (Dataman.Type.toAny x2) |> Dataman.Type.Opaque_) ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.fileType)
                            (Dataman.Type.Record_
                                { name = Nothing
                                , documentation = Nothing
                                , fields =
                                    [ { name = Dataman.Type.FieldName "order", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Order.type_ }
                                    ]
                                }
                            )
                        )
              }
            , { name = Dataman.Type.FieldName "attributes", type_ = Dataman.Type.toAny ((\x x2 -> Dataman.Type.AnyDict (Dataman.Type.toAny x) (Dataman.Type.toAny x2) |> Dataman.Type.Opaque_) ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.attributeType) ElmShop.Document.Utils.AttributeValue.type_) }
            , { name = Dataman.Type.FieldName "related", type_ = Dataman.Type.toAny ((\x x2 -> Dataman.Type.AnyDict (Dataman.Type.toAny x) (Dataman.Type.toAny x2) |> Dataman.Type.Opaque_) ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.productType) (Dataman.Type.Tuple_ { name = Nothing, documentation = Nothing, arguments = [] })) }
            , { name = Dataman.Type.FieldName "categories", type_ = Dataman.Type.toAny ((\x x2 -> Dataman.Type.AnyDict (Dataman.Type.toAny x) (Dataman.Type.toAny x2) |> Dataman.Type.Opaque_) ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.categoryType) (Dataman.Type.Tuple_ { name = Nothing, documentation = Nothing, arguments = [] })) }
            , { name = Dataman.Type.FieldName "meta", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Meta.type_ }
            ]
        }


typeType : Dataman.Type.Type Type
typeType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Product" ] "Type"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Single_", arguments = [ Dataman.Type.toAny singleType ] }
            , [ { name = Dataman.Type.VariantName "Variable_", arguments = [ Dataman.Type.toAny variableType ] }
              , { name = Dataman.Type.VariantName "Set_", arguments = [ Dataman.Type.toAny setType ] }
              ]
            )
        }


singleType : Dataman.Type.Type Single
singleType =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Product" ] "Single")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "price", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Money.type_ }
            ]
        }


variableType : Dataman.Type.Type Variable
variableType =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Product" ] "Variable")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "products", type_ = Dataman.Type.toAny ((\x x2 -> Dataman.Type.AnyDict (Dataman.Type.toAny x) (Dataman.Type.toAny x2) |> Dataman.Type.Opaque_) ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.productType) (Dataman.Type.Tuple_ { name = Nothing, documentation = Nothing, arguments = [] })) }
            ]
        }


setType : Dataman.Type.Type Set
setType =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Product" ] "Set")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "products"
              , type_ =
                    Dataman.Type.toAny
                        ((\x x2 -> Dataman.Type.AnyDict (Dataman.Type.toAny x) (Dataman.Type.toAny x2) |> Dataman.Type.Opaque_) ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.productType)
                            (Dataman.Type.Record_
                                { name = Nothing
                                , documentation = Nothing
                                , fields =
                                    [ { name = Dataman.Type.FieldName "quantity", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Quantity.type_ }
                                    ]
                                }
                            )
                        )
              }
            , { name = Dataman.Type.FieldName "price", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Money.type_ }
            ]
        }


saleType : Dataman.Type.Type Sale
saleType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Product" ] "Sale"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "ForSale", arguments = [] }
            , [ { name = Dataman.Type.VariantName "NotForSale", arguments = [] }
              ]
            )
        }


translationType : Dataman.Type.Type Translation
translationType =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Product" ] "Translation")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "name", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Name.type_ }
            , { name = Dataman.Type.FieldName "content", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Html.type_ }
            ]
        }


skuType : Dataman.Type.Type Sku
skuType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Product" ] "Sku"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Sku", arguments = [ Dataman.Type.toAny (Dataman.Type.String_ |> Dataman.Type.Opaque_) ] }
            , []
            )
        }


stockQuantityType : Dataman.Type.Type StockQuantity
stockQuantityType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Product" ] "StockQuantity"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "StockQuantity", arguments = [ Dataman.Type.toAny (Dataman.Type.Int_ |> Dataman.Type.Opaque_) ] }
            , []
            )
        }


reservationsType : Dataman.Type.Type Reservations
reservationsType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Product" ] "Reservations"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Reservations", arguments = [ Dataman.Type.toAny (Dataman.Type.Int_ |> Dataman.Type.Opaque_) ] }
            , []
            )
        }

module ElmShop.Document.Product exposing (..)

import Codec
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


codec : Codec.Codec Product
codec =
    Codec.object Product
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "type_" .type_ typeCodec
        |> Codec.field "sale" .sale saleCodec
        |> Codec.field "translations" .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field "sku" .sku (Codec.maybe skuCodec)
        |> Codec.field "stock"
            .stock
            (Dict.Any.Codec.dict Reference.toString
                Reference.codec
                (Codec.object (\v -> { quantity = v })
                    |> Codec.field "quantity" .quantity stockQuantityCodec
                    |> Codec.buildObject
                )
            )
        |> Codec.field "reservations" .reservations reservationsCodec
        |> Codec.field "image" .image (Codec.maybe Reference.codec)
        |> Codec.field "gallery"
            .gallery
            (Dict.Any.Codec.dict Reference.toString
                Reference.codec
                (Codec.object (\v -> { order = v })
                    |> Codec.field "order" .order ElmShop.Document.Utils.Order.codec
                    |> Codec.buildObject
                )
            )
        |> Codec.field "attributes" .attributes (Dict.Any.Codec.dict Reference.toString Reference.codec ElmShop.Document.Utils.AttributeValue.codec)
        |> Codec.field "related" .related (Dict.Any.Codec.dict Reference.toString Reference.codec (Codec.succeed ()))
        |> Codec.field "categories" .categories (Dict.Any.Codec.dict Reference.toString Reference.codec (Codec.succeed ()))
        |> Codec.buildObject



--


type Type
    = Single_ Single
    | Variable_ Variable
    | Set_ Set


typeCodec : Codec.Codec Type
typeCodec =
    Codec.custom
        (\fn1 fn2 fn3 v ->
            case v of
                Single_ v1 ->
                    fn1 v1

                Variable_ v1 ->
                    fn2 v1

                Set_ v1 ->
                    fn3 v1
        )
        |> Codec.variant1 "Single_" Single_ singleCodec
        |> Codec.variant1 "Variable_" Variable_ variableCodec
        |> Codec.variant1 "Set_" Set_ setCodec
        |> Codec.buildCustom



--


type alias Single =
    { price : ElmShop.Document.Utils.Money.Money
    }


singleCodec : Codec.Codec Single
singleCodec =
    Codec.object Single
        |> Codec.field "price" .price ElmShop.Document.Utils.Money.codec
        |> Codec.buildObject



--


type alias Variable =
    { products : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Product) ()
    }


variableCodec : Codec.Codec Variable
variableCodec =
    Codec.object Variable
        |> Codec.field "products" .products (Dict.Any.Codec.dict Reference.toString Reference.codec (Codec.succeed ()))
        |> Codec.buildObject



--


type alias Set =
    { products : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Product) { quantity : ElmShop.Document.Utils.Quantity.Quantity }
    , price : ElmShop.Document.Utils.Money.Money
    }


setCodec : Codec.Codec Set
setCodec =
    Codec.object Set
        |> Codec.field "products"
            .products
            (Dict.Any.Codec.dict Reference.toString
                Reference.codec
                (Codec.object (\v -> { quantity = v })
                    |> Codec.field "quantity" .quantity ElmShop.Document.Utils.Quantity.codec
                    |> Codec.buildObject
                )
            )
        |> Codec.field "price" .price ElmShop.Document.Utils.Money.codec
        |> Codec.buildObject



--


type Sale
    = ForSale
    | NotForSale


saleCodec : Codec.Codec Sale
saleCodec =
    Codec.custom
        (\fn1 fn2 v ->
            case v of
                ForSale ->
                    fn1

                NotForSale ->
                    fn2
        )
        |> Codec.variant0 "ForSale" ForSale
        |> Codec.variant0 "NotForSale" NotForSale
        |> Codec.buildCustom



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


type Sku
    = Sku String


skuCodec : Codec.Codec Sku
skuCodec =
    Codec.custom
        (\fn1 v ->
            case v of
                Sku v1 ->
                    fn1 v1
        )
        |> Codec.variant1 "Sku" Sku Codec.string
        |> Codec.buildCustom



--


type Reservations
    = Reservations Int


reservationsCodec : Codec.Codec Reservations
reservationsCodec =
    Codec.custom
        (\fn1 v ->
            case v of
                Reservations v1 ->
                    fn1 v1
        )
        |> Codec.variant1 "Reservations" Reservations Codec.int
        |> Codec.buildCustom



--


type StockQuantity
    = StockQuantity Int


stockQuantityCodec : Codec.Codec StockQuantity
stockQuantityCodec =
    Codec.custom
        (\fn1 v ->
            case v of
                StockQuantity v1 ->
                    fn1 v1
        )
        |> Codec.variant1 "StockQuantity" StockQuantity Codec.int
        |> Codec.buildCustom

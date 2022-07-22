module ElmShop.Document exposing (..)

import Codec
import Dataman.Type
import ElmShop.Document.Attribute
import ElmShop.Document.Category
import ElmShop.Document.Country
import ElmShop.Document.Currency
import ElmShop.Document.File
import ElmShop.Document.Language
import ElmShop.Document.Message
import ElmShop.Document.Order
import ElmShop.Document.OrderStatus
import ElmShop.Document.Page
import ElmShop.Document.Payment
import ElmShop.Document.Product
import ElmShop.Document.Review
import ElmShop.Document.Session
import ElmShop.Document.Shipping
import ElmShop.Document.Site
import ElmShop.Document.Template
import ElmShop.Document.Type
import ElmShop.Document.User
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Warehouse
import Id


type Document
    = Attribute ElmShop.Document.Attribute.Attribute
    | Category ElmShop.Document.Category.Category
    | Country ElmShop.Document.Country.Country
    | Currency ElmShop.Document.Currency.Currency
    | File ElmShop.Document.File.File
    | Language ElmShop.Document.Language.Language
    | Message ElmShop.Document.Message.Message
    | Order ElmShop.Document.Order.Order
    | OrderStatus ElmShop.Document.OrderStatus.OrderStatus
    | Page ElmShop.Document.Page.Page
    | Payment ElmShop.Document.Payment.Payment
    | Product ElmShop.Document.Product.Product
    | Review ElmShop.Document.Review.Review
    | Session ElmShop.Document.Session.Session
    | Shipping ElmShop.Document.Shipping.Shipping
    | Site ElmShop.Document.Site.Site
    | Template ElmShop.Document.Template.Template
    | User ElmShop.Document.User.User
    | Warehouse ElmShop.Document.Warehouse.Warehouse


meta : Document -> ElmShop.Document.Utils.Meta.Meta
meta a =
    case a of
        Attribute b ->
            b.meta

        Category b ->
            b.meta

        Country b ->
            b.meta

        Currency b ->
            b.meta

        File b ->
            b.meta

        Language b ->
            b.meta

        Message b ->
            b.meta

        Order b ->
            b.meta

        OrderStatus b ->
            b.meta

        Page b ->
            b.meta

        Payment b ->
            b.meta

        Product b ->
            b.meta

        Review b ->
            b.meta

        Session b ->
            b.meta

        Shipping b ->
            b.meta

        Site b ->
            b.meta

        Template b ->
            b.meta

        User b ->
            b.meta

        Warehouse b ->
            b.meta


mapMeta : (ElmShop.Document.Utils.Meta.Meta -> ElmShop.Document.Utils.Meta.Meta) -> Document -> Document
mapMeta fn a =
    case a of
        Attribute b ->
            Attribute { b | meta = fn b.meta }

        Category b ->
            Category { b | meta = fn b.meta }

        Country b ->
            Country { b | meta = fn b.meta }

        Currency b ->
            Currency { b | meta = fn b.meta }

        File b ->
            File { b | meta = fn b.meta }

        Language b ->
            Language { b | meta = fn b.meta }

        Message b ->
            Message { b | meta = fn b.meta }

        Order b ->
            Order { b | meta = fn b.meta }

        OrderStatus b ->
            OrderStatus { b | meta = fn b.meta }

        Page b ->
            Page { b | meta = fn b.meta }

        Payment b ->
            Payment { b | meta = fn b.meta }

        Product b ->
            Product { b | meta = fn b.meta }

        Review b ->
            Review { b | meta = fn b.meta }

        Session b ->
            Session { b | meta = fn b.meta }

        Shipping b ->
            Shipping { b | meta = fn b.meta }

        Site b ->
            Site { b | meta = fn b.meta }

        Template b ->
            Template { b | meta = fn b.meta }

        User b ->
            User { b | meta = fn b.meta }

        Warehouse b ->
            Warehouse { b | meta = fn b.meta }


toType : Document -> ElmShop.Document.Type.Type
toType a =
    case a of
        Attribute _ ->
            ElmShop.Document.Type.Attribute_

        Category _ ->
            ElmShop.Document.Type.Category_

        Country _ ->
            ElmShop.Document.Type.Country_

        Currency _ ->
            ElmShop.Document.Type.Currency_

        File _ ->
            ElmShop.Document.Type.File_

        Language _ ->
            ElmShop.Document.Type.Language_

        Message _ ->
            ElmShop.Document.Type.Message_

        Order _ ->
            ElmShop.Document.Type.Order_

        OrderStatus _ ->
            ElmShop.Document.Type.OrderStatus_

        Page _ ->
            ElmShop.Document.Type.Page_

        Payment _ ->
            ElmShop.Document.Type.Payment_

        Product _ ->
            ElmShop.Document.Type.Product_

        Review _ ->
            ElmShop.Document.Type.Review_

        Session _ ->
            ElmShop.Document.Type.Session_

        Shipping _ ->
            ElmShop.Document.Type.Shipping_

        Site _ ->
            ElmShop.Document.Type.Site_

        Template _ ->
            ElmShop.Document.Type.Template_

        User _ ->
            ElmShop.Document.Type.User_

        Warehouse _ ->
            ElmShop.Document.Type.Warehouse_



--


type Msg
    = Create ( Id.Id Document, Document )
    | Remove (Id.Id Document)
    | AttachUserToSession (Maybe (Id.Id ElmShop.Document.Type.User)) (Id.Id ElmShop.Document.Type.Session)



--


codec : Codec.Codec Document
codec =
    Codec.custom
        (\fn1 fn2 fn3 fn4 fn5 fn6 fn7 fn8 fn9 fn10 fn11 fn12 fn13 fn14 fn15 fn16 fn17 fn18 fn19 x ->
            case x of
                Attribute x1 ->
                    fn1 x1

                Category x1 ->
                    fn2 x1

                Country x1 ->
                    fn3 x1

                Currency x1 ->
                    fn4 x1

                File x1 ->
                    fn5 x1

                Language x1 ->
                    fn6 x1

                Message x1 ->
                    fn7 x1

                Order x1 ->
                    fn8 x1

                OrderStatus x1 ->
                    fn9 x1

                Page x1 ->
                    fn10 x1

                Payment x1 ->
                    fn11 x1

                Product x1 ->
                    fn12 x1

                Review x1 ->
                    fn13 x1

                Session x1 ->
                    fn14 x1

                Shipping x1 ->
                    fn15 x1

                Site x1 ->
                    fn16 x1

                Template x1 ->
                    fn17 x1

                User x1 ->
                    fn18 x1

                Warehouse x1 ->
                    fn19 x1
        )
        |> Codec.variant1 Attribute ElmShop.Document.Attribute.codec
        |> Codec.variant1 Category ElmShop.Document.Category.codec
        |> Codec.variant1 Country ElmShop.Document.Country.codec
        |> Codec.variant1 Currency ElmShop.Document.Currency.codec
        |> Codec.variant1 File ElmShop.Document.File.codec
        |> Codec.variant1 Language ElmShop.Document.Language.codec
        |> Codec.variant1 Message ElmShop.Document.Message.codec
        |> Codec.variant1 Order ElmShop.Document.Order.codec
        |> Codec.variant1 OrderStatus ElmShop.Document.OrderStatus.codec
        |> Codec.variant1 Page ElmShop.Document.Page.codec
        |> Codec.variant1 Payment ElmShop.Document.Payment.codec
        |> Codec.variant1 Product ElmShop.Document.Product.codec
        |> Codec.variant1 Review ElmShop.Document.Review.codec
        |> Codec.variant1 Session ElmShop.Document.Session.codec
        |> Codec.variant1 Shipping ElmShop.Document.Shipping.codec
        |> Codec.variant1 Site ElmShop.Document.Site.codec
        |> Codec.variant1 Template ElmShop.Document.Template.codec
        |> Codec.variant1 User ElmShop.Document.User.codec
        |> Codec.variant1 Warehouse ElmShop.Document.Warehouse.codec
        |> Codec.buildCustom


msgCodec : Codec.Codec Msg
msgCodec =
    Codec.lazy
        (\() ->
            Codec.custom
                (\fn1 fn2 fn3 x ->
                    case x of
                        Create x1 ->
                            fn1 x1

                        Remove x1 ->
                            fn2 x1

                        AttachUserToSession x1 x2 ->
                            fn3 x1 x2
                )
                |> Codec.variant1 Create (Codec.tuple Id.codec codec)
                |> Codec.variant1 Remove Id.codec
                |> Codec.variant2 AttachUserToSession (Codec.maybe Id.codec) Id.codec
                |> Codec.buildCustom
        )


type_ : Dataman.Type.Type Document
type_ =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document" ] "Document"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Attribute", arguments = [ Dataman.Type.toAny ElmShop.Document.Attribute.type_ ] }
            , [ { name = Dataman.Type.VariantName "Category", arguments = [ Dataman.Type.toAny ElmShop.Document.Category.type_ ] }
              , { name = Dataman.Type.VariantName "Country", arguments = [ Dataman.Type.toAny ElmShop.Document.Country.type_ ] }
              , { name = Dataman.Type.VariantName "Currency", arguments = [ Dataman.Type.toAny ElmShop.Document.Currency.type_ ] }
              , { name = Dataman.Type.VariantName "File", arguments = [ Dataman.Type.toAny ElmShop.Document.File.type_ ] }
              , { name = Dataman.Type.VariantName "Language", arguments = [ Dataman.Type.toAny ElmShop.Document.Language.type_ ] }
              , { name = Dataman.Type.VariantName "Message", arguments = [ Dataman.Type.toAny ElmShop.Document.Message.type_ ] }
              , { name = Dataman.Type.VariantName "Order", arguments = [ Dataman.Type.toAny ElmShop.Document.Order.type_ ] }
              , { name = Dataman.Type.VariantName "OrderStatus", arguments = [ Dataman.Type.toAny ElmShop.Document.OrderStatus.type_ ] }
              , { name = Dataman.Type.VariantName "Page", arguments = [ Dataman.Type.toAny ElmShop.Document.Page.type_ ] }
              , { name = Dataman.Type.VariantName "Payment", arguments = [ Dataman.Type.toAny ElmShop.Document.Payment.type_ ] }
              , { name = Dataman.Type.VariantName "Product", arguments = [ Dataman.Type.toAny ElmShop.Document.Product.type_ ] }
              , { name = Dataman.Type.VariantName "Review", arguments = [ Dataman.Type.toAny ElmShop.Document.Review.type_ ] }
              , { name = Dataman.Type.VariantName "Session", arguments = [ Dataman.Type.toAny ElmShop.Document.Session.type_ ] }
              , { name = Dataman.Type.VariantName "Shipping", arguments = [ Dataman.Type.toAny ElmShop.Document.Shipping.type_ ] }
              , { name = Dataman.Type.VariantName "Site", arguments = [ Dataman.Type.toAny ElmShop.Document.Site.type_ ] }
              , { name = Dataman.Type.VariantName "Template", arguments = [ Dataman.Type.toAny ElmShop.Document.Template.type_ ] }
              , { name = Dataman.Type.VariantName "User", arguments = [ Dataman.Type.toAny ElmShop.Document.User.type_ ] }
              , { name = Dataman.Type.VariantName "Warehouse", arguments = [ Dataman.Type.toAny ElmShop.Document.Warehouse.type_ ] }
              ]
            )
        }

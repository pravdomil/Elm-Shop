module ElmShop.Document exposing (..)

import Codec
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


id : Document -> Id.Id Document
id a =
    case a of
        Attribute b ->
            Id.toAny b.id

        Category b ->
            Id.toAny b.id

        Country b ->
            Id.toAny b.id

        Currency b ->
            Id.toAny b.id

        File b ->
            Id.toAny b.id

        Language b ->
            Id.toAny b.id

        Message b ->
            Id.toAny b.id

        Order b ->
            Id.toAny b.id

        OrderStatus b ->
            Id.toAny b.id

        Page b ->
            Id.toAny b.id

        Payment b ->
            Id.toAny b.id

        Product b ->
            Id.toAny b.id

        Review b ->
            Id.toAny b.id

        Session b ->
            Id.toAny b.id

        Shipping b ->
            Id.toAny b.id

        Site b ->
            Id.toAny b.id

        Template b ->
            Id.toAny b.id

        User b ->
            Id.toAny b.id

        Warehouse b ->
            Id.toAny b.id


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
        |> Codec.variant1 "Attribute" Attribute ElmShop.Document.Attribute.codec
        |> Codec.variant1 "Category" Category ElmShop.Document.Category.codec
        |> Codec.variant1 "Country" Country ElmShop.Document.Country.codec
        |> Codec.variant1 "Currency" Currency ElmShop.Document.Currency.codec
        |> Codec.variant1 "File" File ElmShop.Document.File.codec
        |> Codec.variant1 "Language" Language ElmShop.Document.Language.codec
        |> Codec.variant1 "Message" Message ElmShop.Document.Message.codec
        |> Codec.variant1 "Order" Order ElmShop.Document.Order.codec
        |> Codec.variant1 "OrderStatus" OrderStatus ElmShop.Document.OrderStatus.codec
        |> Codec.variant1 "Page" Page ElmShop.Document.Page.codec
        |> Codec.variant1 "Payment" Payment ElmShop.Document.Payment.codec
        |> Codec.variant1 "Product" Product ElmShop.Document.Product.codec
        |> Codec.variant1 "Review" Review ElmShop.Document.Review.codec
        |> Codec.variant1 "Session" Session ElmShop.Document.Session.codec
        |> Codec.variant1 "Shipping" Shipping ElmShop.Document.Shipping.codec
        |> Codec.variant1 "Site" Site ElmShop.Document.Site.codec
        |> Codec.variant1 "Template" Template ElmShop.Document.Template.codec
        |> Codec.variant1 "User" User ElmShop.Document.User.codec
        |> Codec.variant1 "Warehouse" Warehouse ElmShop.Document.Warehouse.codec
        |> Codec.buildCustom



--


type Msg
    = Create Document
    | Remove Document
    | AttachUserToSession (Maybe (Id.Id ElmShop.Document.Type.User)) (Id.Id ElmShop.Document.Type.Session)


msgCodec : Codec.Codec Msg
msgCodec =
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
        |> Codec.variant1 "Create" Create codec
        |> Codec.variant1 "Remove" Remove codec
        |> Codec.variant2 "AttachUserToSession" AttachUserToSession (Codec.maybe Id.codec) Id.codec
        |> Codec.buildCustom

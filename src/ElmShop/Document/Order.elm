module ElmShop.Document.Order exposing (..)

import Codec
import Codec.Extra
import Dataman.Schema
import Dataman.Schema.Basics
import Dict.Any
import Dict.Any.Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.Address
import ElmShop.Document.Utils.Email
import ElmShop.Document.Utils.Html
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Money
import ElmShop.Document.Utils.Name
import ElmShop.Document.Utils.Phone
import ElmShop.Document.Utils.Quantity
import ElmShop.Document.Utils.TimeZone
import Id
import Reference
import Time
import Time.Codec


type alias Order =
    { id : Id.Id ElmShop.Document.Type.Order
    , meta : ElmShop.Document.Utils.Meta.Meta

    --
    , number : Number
    , client : Client
    , billing : Billing

    --
    , site : Reference.Reference ElmShop.Document.Type.Site
    , language : Reference.Reference ElmShop.Document.Type.Language

    --
    , currency : Currency
    , cart : Dict.Any.Dict (Id.Id CartItem) CartItem
    , shipping : Dict.Any.Dict (Id.Id Shipping) Shipping
    , payments : Dict.Any.Dict (Id.Id Payment) Payment
    , messages : Dict.Any.Dict (Id.Id Message) Message
    }



--


type Number
    = Number Int



--


type alias Client =
    { email : ElmShop.Document.Utils.Email.Email
    , phone : ElmShop.Document.Utils.Phone.Phone
    , timeZone : ElmShop.Document.Utils.TimeZone.TimeZone
    , note : ClientNote
    }



--


type ClientNote
    = ClientNote String



--


type alias Billing =
    { address : Maybe ElmShop.Document.Utils.Address.Address
    , note : BillingNote
    }



--


type BillingNote
    = BillingNote String



--


type alias Currency =
    { id : Reference.Reference ElmShop.Document.Type.Currency
    , value : ElmShop.Document.Utils.Money.Money
    }



--


type alias CartItem =
    { created : Time.Posix

    --
    , name : ElmShop.Document.Utils.Name.Name
    , price : ElmShop.Document.Utils.Money.Money
    , quantity : ElmShop.Document.Utils.Quantity.Quantity

    --
    , type_ : CartItemType
    }



--


type CartItemType
    = ProductCartItem (Reference.Reference ElmShop.Document.Type.Product) (Maybe (Reference.Reference ElmShop.Document.Type.Product))



--


type alias Shipping =
    { created : Time.Posix

    --
    , name : ElmShop.Document.Utils.Name.Name
    , price : ElmShop.Document.Utils.Money.Money
    , address : Maybe ElmShop.Document.Utils.Address.Address

    --
    , shipping : Reference.Reference ElmShop.Document.Type.Shipping
    }



--


type alias Payment =
    { created : Time.Posix

    --
    , name : ElmShop.Document.Utils.Name.Name
    , price : ElmShop.Document.Utils.Money.Money

    --
    , payment : Reference.Reference ElmShop.Document.Type.Payment
    }



--


type alias Message =
    { created : Time.Posix

    --
    , status : Maybe (Reference.Reference ElmShop.Document.Type.OrderStatus)
    , content : ElmShop.Document.Utils.Html.Html
    , notification : MessageNotification
    }



--


type MessageNotification
    = NoNotification
    | NotifyClient



--


codec : Codec.Codec Order
codec =
    Codec.object (\x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 -> { id = x1, meta = x2, number = x3, client = x4, billing = x5, site = x6, language = x7, currency = x8, cart = x9, shipping = x10, payments = x11, messages = x12 })
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "number" .number numberCodec
        |> Codec.field "client" .client clientCodec
        |> Codec.field "billing" .billing billingCodec
        |> Codec.field "site" .site Reference.codec
        |> Codec.field "language" .language Reference.codec
        |> Codec.field "currency" .currency currencyCodec
        |> Codec.field "cart" .cart (Dict.Any.Codec.dict Id.toString Id.codec cartItemCodec)
        |> Codec.field "shipping" .shipping (Dict.Any.Codec.dict Id.toString Id.codec shippingCodec)
        |> Codec.field "payments" .payments (Dict.Any.Codec.dict Id.toString Id.codec paymentCodec)
        |> Codec.field "messages" .messages (Dict.Any.Codec.dict Id.toString Id.codec messageCodec)
        |> Codec.buildObject


messageCodec : Codec.Codec Message
messageCodec =
    Codec.object (\x1 x2 x3 x4 -> { created = x1, status = x2, content = x3, notification = x4 })
        |> Codec.field "created" .created Time.Codec.posix
        |> Codec.field "status" .status (Codec.Extra.maybe Reference.codec)
        |> Codec.field "content" .content ElmShop.Document.Utils.Html.codec
        |> Codec.field "notification" .notification messageNotificationCodec
        |> Codec.buildObject


messageNotificationCodec : Codec.Codec MessageNotification
messageNotificationCodec =
    Codec.custom
        (\fn1 fn2 x ->
            case x of
                NoNotification ->
                    fn1

                NotifyClient ->
                    fn2
        )
        |> Codec.variant0 "NoNotification" NoNotification
        |> Codec.variant0 "NotifyClient" NotifyClient
        |> Codec.buildCustom


paymentCodec : Codec.Codec Payment
paymentCodec =
    Codec.object (\x1 x2 x3 x4 -> { created = x1, name = x2, price = x3, payment = x4 })
        |> Codec.field "created" .created Time.Codec.posix
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "price" .price ElmShop.Document.Utils.Money.codec
        |> Codec.field "payment" .payment Reference.codec
        |> Codec.buildObject


shippingCodec : Codec.Codec Shipping
shippingCodec =
    Codec.object (\x1 x2 x3 x4 x5 -> { created = x1, name = x2, price = x3, address = x4, shipping = x5 })
        |> Codec.field "created" .created Time.Codec.posix
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "price" .price ElmShop.Document.Utils.Money.codec
        |> Codec.field "address" .address (Codec.Extra.maybe ElmShop.Document.Utils.Address.codec)
        |> Codec.field "shipping" .shipping Reference.codec
        |> Codec.buildObject


cartItemCodec : Codec.Codec CartItem
cartItemCodec =
    Codec.object (\x1 x2 x3 x4 x5 -> { created = x1, name = x2, price = x3, quantity = x4, type_ = x5 })
        |> Codec.field "created" .created Time.Codec.posix
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "price" .price ElmShop.Document.Utils.Money.codec
        |> Codec.field "quantity" .quantity ElmShop.Document.Utils.Quantity.codec
        |> Codec.field "type_" .type_ cartItemTypeCodec
        |> Codec.buildObject


cartItemTypeCodec : Codec.Codec CartItemType
cartItemTypeCodec =
    Codec.custom
        (\fn1 x ->
            case x of
                ProductCartItem x1 x2 ->
                    fn1 x1 x2
        )
        |> Codec.variant2 "ProductCartItem" ProductCartItem Reference.codec (Codec.Extra.maybe Reference.codec)
        |> Codec.buildCustom


currencyCodec : Codec.Codec Currency
currencyCodec =
    Codec.object (\x1 x2 -> { id = x1, value = x2 })
        |> Codec.field "id" .id Reference.codec
        |> Codec.field "value" .value ElmShop.Document.Utils.Money.codec
        |> Codec.buildObject


billingCodec : Codec.Codec Billing
billingCodec =
    Codec.object (\x1 x2 -> { address = x1, note = x2 })
        |> Codec.field "address" .address (Codec.Extra.maybe ElmShop.Document.Utils.Address.codec)
        |> Codec.field "note" .note billingNoteCodec
        |> Codec.buildObject


billingNoteCodec : Codec.Codec BillingNote
billingNoteCodec =
    Codec.custom
        (\fn1 x ->
            case x of
                BillingNote x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "BillingNote" BillingNote Codec.string
        |> Codec.buildCustom


clientCodec : Codec.Codec Client
clientCodec =
    Codec.object (\x1 x2 x3 x4 -> { email = x1, phone = x2, timeZone = x3, note = x4 })
        |> Codec.field "email" .email ElmShop.Document.Utils.Email.codec
        |> Codec.field "phone" .phone ElmShop.Document.Utils.Phone.codec
        |> Codec.field "timeZone" .timeZone ElmShop.Document.Utils.TimeZone.codec
        |> Codec.field "note" .note clientNoteCodec
        |> Codec.buildObject


clientNoteCodec : Codec.Codec ClientNote
clientNoteCodec =
    Codec.custom
        (\fn1 x ->
            case x of
                ClientNote x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "ClientNote" ClientNote Codec.string
        |> Codec.buildCustom


numberCodec : Codec.Codec Number
numberCodec =
    Codec.custom
        (\fn1 x ->
            case x of
                Number x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "Number" Number Codec.int
        |> Codec.buildCustom


schema : Dataman.Schema.Schema Order
schema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Order" ] "Order"))
        Nothing
        [ Dataman.Schema.RecordField "id" (Dataman.Schema.toAny (Dataman.Schema.Basics.id ElmShop.Document.Type.orderSchema))
        , Dataman.Schema.RecordField "meta" (Dataman.Schema.toAny ElmShop.Document.Utils.Meta.schema)
        , Dataman.Schema.RecordField "number" (Dataman.Schema.toAny numberSchema)
        , Dataman.Schema.RecordField "client" (Dataman.Schema.toAny clientSchema)
        , Dataman.Schema.RecordField "billing" (Dataman.Schema.toAny billingSchema)
        , Dataman.Schema.RecordField "site" (Dataman.Schema.toAny (Dataman.Schema.Basics.reference ElmShop.Document.Type.siteSchema))
        , Dataman.Schema.RecordField "language" (Dataman.Schema.toAny (Dataman.Schema.Basics.reference ElmShop.Document.Type.languageSchema))
        , Dataman.Schema.RecordField "currency" (Dataman.Schema.toAny currencySchema)
        , Dataman.Schema.RecordField "cart" (Dataman.Schema.toAny (Dataman.Schema.Basics.anyDict (Dataman.Schema.Basics.id cartItemSchema) cartItemSchema))
        , Dataman.Schema.RecordField "shipping" (Dataman.Schema.toAny (Dataman.Schema.Basics.anyDict (Dataman.Schema.Basics.id shippingSchema) shippingSchema))
        , Dataman.Schema.RecordField "payments" (Dataman.Schema.toAny (Dataman.Schema.Basics.anyDict (Dataman.Schema.Basics.id paymentSchema) paymentSchema))
        , Dataman.Schema.RecordField "messages" (Dataman.Schema.toAny (Dataman.Schema.Basics.anyDict (Dataman.Schema.Basics.id messageSchema) messageSchema))
        ]


numberSchema : Dataman.Schema.Schema Number
numberSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Order" ] "Number")
        Nothing
        (Dataman.Schema.Variant "Number" [ Dataman.Schema.toAny Dataman.Schema.Basics.int ])
        []


clientSchema : Dataman.Schema.Schema Client
clientSchema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Order" ] "Client"))
        Nothing
        [ Dataman.Schema.RecordField "email" (Dataman.Schema.toAny ElmShop.Document.Utils.Email.schema)
        , Dataman.Schema.RecordField "phone" (Dataman.Schema.toAny ElmShop.Document.Utils.Phone.schema)
        , Dataman.Schema.RecordField "timeZone" (Dataman.Schema.toAny ElmShop.Document.Utils.TimeZone.schema)
        , Dataman.Schema.RecordField "note" (Dataman.Schema.toAny clientNoteSchema)
        ]


clientNoteSchema : Dataman.Schema.Schema ClientNote
clientNoteSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Order" ] "ClientNote")
        Nothing
        (Dataman.Schema.Variant "ClientNote" [ Dataman.Schema.toAny Dataman.Schema.Basics.string ])
        []


billingSchema : Dataman.Schema.Schema Billing
billingSchema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Order" ] "Billing"))
        Nothing
        [ Dataman.Schema.RecordField "address" (Dataman.Schema.toAny (Dataman.Schema.Basics.maybe ElmShop.Document.Utils.Address.schema))
        , Dataman.Schema.RecordField "note" (Dataman.Schema.toAny billingNoteSchema)
        ]


billingNoteSchema : Dataman.Schema.Schema BillingNote
billingNoteSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Order" ] "BillingNote")
        Nothing
        (Dataman.Schema.Variant "BillingNote" [ Dataman.Schema.toAny Dataman.Schema.Basics.string ])
        []


currencySchema : Dataman.Schema.Schema Currency
currencySchema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Order" ] "Currency"))
        Nothing
        [ Dataman.Schema.RecordField "id" (Dataman.Schema.toAny (Dataman.Schema.Basics.reference ElmShop.Document.Type.currencySchema))
        , Dataman.Schema.RecordField "value" (Dataman.Schema.toAny ElmShop.Document.Utils.Money.schema)
        ]


cartItemSchema : Dataman.Schema.Schema CartItem
cartItemSchema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Order" ] "CartItem"))
        Nothing
        [ Dataman.Schema.RecordField "created" (Dataman.Schema.toAny Dataman.Schema.Basics.time)
        , Dataman.Schema.RecordField "name" (Dataman.Schema.toAny ElmShop.Document.Utils.Name.schema)
        , Dataman.Schema.RecordField "price" (Dataman.Schema.toAny ElmShop.Document.Utils.Money.schema)
        , Dataman.Schema.RecordField "quantity" (Dataman.Schema.toAny ElmShop.Document.Utils.Quantity.schema)
        , Dataman.Schema.RecordField "type_" (Dataman.Schema.toAny cartItemTypeSchema)
        ]


cartItemTypeSchema : Dataman.Schema.Schema CartItemType
cartItemTypeSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Order" ] "CartItemType")
        Nothing
        (Dataman.Schema.Variant "ProductCartItem" [ Dataman.Schema.toAny (Dataman.Schema.Basics.reference ElmShop.Document.Type.productSchema), Dataman.Schema.toAny (Dataman.Schema.Basics.maybe (Dataman.Schema.Basics.reference ElmShop.Document.Type.productSchema)) ])
        []


shippingSchema : Dataman.Schema.Schema Shipping
shippingSchema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Order" ] "Shipping"))
        Nothing
        [ Dataman.Schema.RecordField "created" (Dataman.Schema.toAny Dataman.Schema.Basics.time)
        , Dataman.Schema.RecordField "name" (Dataman.Schema.toAny ElmShop.Document.Utils.Name.schema)
        , Dataman.Schema.RecordField "price" (Dataman.Schema.toAny ElmShop.Document.Utils.Money.schema)
        , Dataman.Schema.RecordField "address" (Dataman.Schema.toAny (Dataman.Schema.Basics.maybe ElmShop.Document.Utils.Address.schema))
        , Dataman.Schema.RecordField "shipping" (Dataman.Schema.toAny (Dataman.Schema.Basics.reference ElmShop.Document.Type.shippingSchema))
        ]


paymentSchema : Dataman.Schema.Schema Payment
paymentSchema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Order" ] "Payment"))
        Nothing
        [ Dataman.Schema.RecordField "created" (Dataman.Schema.toAny Dataman.Schema.Basics.time)
        , Dataman.Schema.RecordField "name" (Dataman.Schema.toAny ElmShop.Document.Utils.Name.schema)
        , Dataman.Schema.RecordField "price" (Dataman.Schema.toAny ElmShop.Document.Utils.Money.schema)
        , Dataman.Schema.RecordField "payment" (Dataman.Schema.toAny (Dataman.Schema.Basics.reference ElmShop.Document.Type.paymentSchema))
        ]


messageSchema : Dataman.Schema.Schema Message
messageSchema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Order" ] "Message"))
        Nothing
        [ Dataman.Schema.RecordField "created" (Dataman.Schema.toAny Dataman.Schema.Basics.time)
        , Dataman.Schema.RecordField "status" (Dataman.Schema.toAny (Dataman.Schema.Basics.maybe (Dataman.Schema.Basics.reference ElmShop.Document.Type.orderStatusSchema)))
        , Dataman.Schema.RecordField "content" (Dataman.Schema.toAny ElmShop.Document.Utils.Html.schema)
        , Dataman.Schema.RecordField "notification" (Dataman.Schema.toAny messageNotificationSchema)
        ]


messageNotificationSchema : Dataman.Schema.Schema MessageNotification
messageNotificationSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Order" ] "MessageNotification")
        Nothing
        (Dataman.Schema.Variant "NoNotification" [])
        [ Dataman.Schema.Variant "NotifyClient" []
        ]

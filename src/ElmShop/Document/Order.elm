module ElmShop.Document.Order exposing (..)

import Codec
import Dataman.Type
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
    { number : Number
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

    --
    , meta : ElmShop.Document.Utils.Meta.Meta
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
    Codec.record (\x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 -> { number = x1, client = x2, billing = x3, site = x4, language = x5, currency = x6, cart = x7, shipping = x8, payments = x9, messages = x10, meta = x11 })
        |> Codec.field .number numberCodec
        |> Codec.field .client clientCodec
        |> Codec.field .billing billingCodec
        |> Codec.field .site Reference.codec
        |> Codec.field .language Reference.codec
        |> Codec.field .currency currencyCodec
        |> Codec.field .cart (Dict.Any.Codec.dict Id.toString Id.codec cartItemCodec)
        |> Codec.field .shipping (Dict.Any.Codec.dict Id.toString Id.codec shippingCodec)
        |> Codec.field .payments (Dict.Any.Codec.dict Id.toString Id.codec paymentCodec)
        |> Codec.field .messages (Dict.Any.Codec.dict Id.toString Id.codec messageCodec)
        |> Codec.field .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.buildRecord


messageCodec : Codec.Codec Message
messageCodec =
    Codec.record (\x1 x2 x3 x4 -> { created = x1, status = x2, content = x3, notification = x4 })
        |> Codec.field .created Time.Codec.posix
        |> Codec.field .status (Codec.maybe Reference.codec)
        |> Codec.field .content ElmShop.Document.Utils.Html.codec
        |> Codec.field .notification messageNotificationCodec
        |> Codec.buildRecord


messageNotificationCodec : Codec.Codec MessageNotification
messageNotificationCodec =
    Codec.lazy
        (\() ->
            Codec.custom
                (\fn1 fn2 x ->
                    case x of
                        NoNotification ->
                            fn1

                        NotifyClient ->
                            fn2
                )
                |> Codec.variant0 NoNotification
                |> Codec.variant0 NotifyClient
                |> Codec.buildCustom
        )


paymentCodec : Codec.Codec Payment
paymentCodec =
    Codec.record (\x1 x2 x3 x4 -> { created = x1, name = x2, price = x3, payment = x4 })
        |> Codec.field .created Time.Codec.posix
        |> Codec.field .name ElmShop.Document.Utils.Name.codec
        |> Codec.field .price ElmShop.Document.Utils.Money.codec
        |> Codec.field .payment Reference.codec
        |> Codec.buildRecord


shippingCodec : Codec.Codec Shipping
shippingCodec =
    Codec.record (\x1 x2 x3 x4 x5 -> { created = x1, name = x2, price = x3, address = x4, shipping = x5 })
        |> Codec.field .created Time.Codec.posix
        |> Codec.field .name ElmShop.Document.Utils.Name.codec
        |> Codec.field .price ElmShop.Document.Utils.Money.codec
        |> Codec.field .address (Codec.maybe ElmShop.Document.Utils.Address.codec)
        |> Codec.field .shipping Reference.codec
        |> Codec.buildRecord


cartItemCodec : Codec.Codec CartItem
cartItemCodec =
    Codec.record (\x1 x2 x3 x4 x5 -> { created = x1, name = x2, price = x3, quantity = x4, type_ = x5 })
        |> Codec.field .created Time.Codec.posix
        |> Codec.field .name ElmShop.Document.Utils.Name.codec
        |> Codec.field .price ElmShop.Document.Utils.Money.codec
        |> Codec.field .quantity ElmShop.Document.Utils.Quantity.codec
        |> Codec.field .type_ cartItemTypeCodec
        |> Codec.buildRecord


cartItemTypeCodec : Codec.Codec CartItemType
cartItemTypeCodec =
    Codec.lazy
        (\() ->
            Codec.custom
                (\fn1 x ->
                    case x of
                        ProductCartItem x1 x2 ->
                            fn1 x1 x2
                )
                |> Codec.variant2 ProductCartItem Reference.codec (Codec.maybe Reference.codec)
                |> Codec.buildCustom
        )


currencyCodec : Codec.Codec Currency
currencyCodec =
    Codec.record (\x1 x2 -> { id = x1, value = x2 })
        |> Codec.field .id Reference.codec
        |> Codec.field .value ElmShop.Document.Utils.Money.codec
        |> Codec.buildRecord


billingCodec : Codec.Codec Billing
billingCodec =
    Codec.record (\x1 x2 -> { address = x1, note = x2 })
        |> Codec.field .address (Codec.maybe ElmShop.Document.Utils.Address.codec)
        |> Codec.field .note billingNoteCodec
        |> Codec.buildRecord


billingNoteCodec : Codec.Codec BillingNote
billingNoteCodec =
    Codec.lazy
        (\() ->
            Codec.custom
                (\fn1 x ->
                    case x of
                        BillingNote x1 ->
                            fn1 x1
                )
                |> Codec.variant1 BillingNote Codec.string
                |> Codec.buildCustom
        )


clientCodec : Codec.Codec Client
clientCodec =
    Codec.record (\x1 x2 x3 x4 -> { email = x1, phone = x2, timeZone = x3, note = x4 })
        |> Codec.field .email ElmShop.Document.Utils.Email.codec
        |> Codec.field .phone ElmShop.Document.Utils.Phone.codec
        |> Codec.field .timeZone ElmShop.Document.Utils.TimeZone.codec
        |> Codec.field .note clientNoteCodec
        |> Codec.buildRecord


clientNoteCodec : Codec.Codec ClientNote
clientNoteCodec =
    Codec.lazy
        (\() ->
            Codec.custom
                (\fn1 x ->
                    case x of
                        ClientNote x1 ->
                            fn1 x1
                )
                |> Codec.variant1 ClientNote Codec.string
                |> Codec.buildCustom
        )


numberCodec : Codec.Codec Number
numberCodec =
    Codec.lazy
        (\() ->
            Codec.custom
                (\fn1 x ->
                    case x of
                        Number x1 ->
                            fn1 x1
                )
                |> Codec.variant1 Number Codec.int
                |> Codec.buildCustom
        )


type_ : Dataman.Type.Type Order
type_ =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Order" ] "Order")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "number", type_ = Dataman.Type.toAny numberType }
            , { name = Dataman.Type.FieldName "client", type_ = Dataman.Type.toAny clientType }
            , { name = Dataman.Type.FieldName "billing", type_ = Dataman.Type.toAny billingType }
            , { name = Dataman.Type.FieldName "site", type_ = Dataman.Type.toAny ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.siteType) }
            , { name = Dataman.Type.FieldName "language", type_ = Dataman.Type.toAny ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.languageType) }
            , { name = Dataman.Type.FieldName "currency", type_ = Dataman.Type.toAny currencyType }
            , { name = Dataman.Type.FieldName "cart", type_ = Dataman.Type.toAny ((\x x2 -> Dataman.Type.AnyDict (Dataman.Type.toAny x) (Dataman.Type.toAny x2) |> Dataman.Type.Opaque_) ((Dataman.Type.toAny >> Dataman.Type.Id >> Dataman.Type.Opaque_) cartItemType) cartItemType) }
            , { name = Dataman.Type.FieldName "shipping", type_ = Dataman.Type.toAny ((\x x2 -> Dataman.Type.AnyDict (Dataman.Type.toAny x) (Dataman.Type.toAny x2) |> Dataman.Type.Opaque_) ((Dataman.Type.toAny >> Dataman.Type.Id >> Dataman.Type.Opaque_) shippingType) shippingType) }
            , { name = Dataman.Type.FieldName "payments", type_ = Dataman.Type.toAny ((\x x2 -> Dataman.Type.AnyDict (Dataman.Type.toAny x) (Dataman.Type.toAny x2) |> Dataman.Type.Opaque_) ((Dataman.Type.toAny >> Dataman.Type.Id >> Dataman.Type.Opaque_) paymentType) paymentType) }
            , { name = Dataman.Type.FieldName "messages", type_ = Dataman.Type.toAny ((\x x2 -> Dataman.Type.AnyDict (Dataman.Type.toAny x) (Dataman.Type.toAny x2) |> Dataman.Type.Opaque_) ((Dataman.Type.toAny >> Dataman.Type.Id >> Dataman.Type.Opaque_) messageType) messageType) }
            , { name = Dataman.Type.FieldName "meta", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Meta.type_ }
            ]
        }


numberType : Dataman.Type.Type Number
numberType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Order" ] "Number"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Number", arguments = [ Dataman.Type.toAny (Dataman.Type.Int_ |> Dataman.Type.Opaque_) ] }
            , []
            )
        }


clientType : Dataman.Type.Type Client
clientType =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Order" ] "Client")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "email", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Email.type_ }
            , { name = Dataman.Type.FieldName "phone", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Phone.type_ }
            , { name = Dataman.Type.FieldName "timeZone", type_ = Dataman.Type.toAny ElmShop.Document.Utils.TimeZone.type_ }
            , { name = Dataman.Type.FieldName "note", type_ = Dataman.Type.toAny clientNoteType }
            ]
        }


clientNoteType : Dataman.Type.Type ClientNote
clientNoteType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Order" ] "ClientNote"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "ClientNote", arguments = [ Dataman.Type.toAny (Dataman.Type.String_ |> Dataman.Type.Opaque_) ] }
            , []
            )
        }


billingType : Dataman.Type.Type Billing
billingType =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Order" ] "Billing")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "address", type_ = Dataman.Type.toAny (Dataman.Type.maybe ElmShop.Document.Utils.Address.type_) }
            , { name = Dataman.Type.FieldName "note", type_ = Dataman.Type.toAny billingNoteType }
            ]
        }


billingNoteType : Dataman.Type.Type BillingNote
billingNoteType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Order" ] "BillingNote"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "BillingNote", arguments = [ Dataman.Type.toAny (Dataman.Type.String_ |> Dataman.Type.Opaque_) ] }
            , []
            )
        }


currencyType : Dataman.Type.Type Currency
currencyType =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Order" ] "Currency")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "id", type_ = Dataman.Type.toAny ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.currencyType) }
            , { name = Dataman.Type.FieldName "value", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Money.type_ }
            ]
        }


cartItemType : Dataman.Type.Type CartItem
cartItemType =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Order" ] "CartItem")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "created", type_ = Dataman.Type.toAny (Dataman.Type.TimePosix |> Dataman.Type.Opaque_) }
            , { name = Dataman.Type.FieldName "name", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Name.type_ }
            , { name = Dataman.Type.FieldName "price", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Money.type_ }
            , { name = Dataman.Type.FieldName "quantity", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Quantity.type_ }
            , { name = Dataman.Type.FieldName "type_", type_ = Dataman.Type.toAny cartItemTypeType }
            ]
        }


cartItemTypeType : Dataman.Type.Type CartItemType
cartItemTypeType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Order" ] "CartItemType"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "ProductCartItem", arguments = [ Dataman.Type.toAny ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.productType), Dataman.Type.toAny (Dataman.Type.maybe ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.productType)) ] }
            , []
            )
        }


shippingType : Dataman.Type.Type Shipping
shippingType =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Order" ] "Shipping")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "created", type_ = Dataman.Type.toAny (Dataman.Type.TimePosix |> Dataman.Type.Opaque_) }
            , { name = Dataman.Type.FieldName "name", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Name.type_ }
            , { name = Dataman.Type.FieldName "price", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Money.type_ }
            , { name = Dataman.Type.FieldName "address", type_ = Dataman.Type.toAny (Dataman.Type.maybe ElmShop.Document.Utils.Address.type_) }
            , { name = Dataman.Type.FieldName "shipping", type_ = Dataman.Type.toAny ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.shippingType) }
            ]
        }


paymentType : Dataman.Type.Type Payment
paymentType =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Order" ] "Payment")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "created", type_ = Dataman.Type.toAny (Dataman.Type.TimePosix |> Dataman.Type.Opaque_) }
            , { name = Dataman.Type.FieldName "name", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Name.type_ }
            , { name = Dataman.Type.FieldName "price", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Money.type_ }
            , { name = Dataman.Type.FieldName "payment", type_ = Dataman.Type.toAny ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.paymentType) }
            ]
        }


messageType : Dataman.Type.Type Message
messageType =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Order" ] "Message")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "created", type_ = Dataman.Type.toAny (Dataman.Type.TimePosix |> Dataman.Type.Opaque_) }
            , { name = Dataman.Type.FieldName "status", type_ = Dataman.Type.toAny (Dataman.Type.maybe ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.orderStatusType)) }
            , { name = Dataman.Type.FieldName "content", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Html.type_ }
            , { name = Dataman.Type.FieldName "notification", type_ = Dataman.Type.toAny messageNotificationType }
            ]
        }


messageNotificationType : Dataman.Type.Type MessageNotification
messageNotificationType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Order" ] "MessageNotification"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "NoNotification", arguments = [] }
            , [ { name = Dataman.Type.VariantName "NotifyClient", arguments = [] }
              ]
            )
        }

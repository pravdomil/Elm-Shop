module ElmShop.Document.Order exposing (..)

import Codec
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


codec : Codec.Codec Order
codec =
    Codec.object Order
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



--


type Number
    = Number Int


numberCodec : Codec.Codec Number
numberCodec =
    Codec.custom
        (\fn1 v ->
            case v of
                Number v1 ->
                    fn1 v1
        )
        |> Codec.variant1 "Number" Number Codec.int
        |> Codec.buildCustom



--


type alias Client =
    { email : ElmShop.Document.Utils.Email.Email
    , phone : ElmShop.Document.Utils.Phone.Phone
    , timeZone : ElmShop.Document.Utils.TimeZone.TimeZone
    , note : ClientNote
    }


clientCodec : Codec.Codec Client
clientCodec =
    Codec.object Client
        |> Codec.field "email" .email ElmShop.Document.Utils.Email.codec
        |> Codec.field "phone" .phone ElmShop.Document.Utils.Phone.codec
        |> Codec.field "timeZone" .timeZone ElmShop.Document.Utils.TimeZone.codec
        |> Codec.field "note" .note clientNoteCodec
        |> Codec.buildObject



--


type ClientNote
    = ClientNote String


clientNoteCodec : Codec.Codec ClientNote
clientNoteCodec =
    Codec.custom
        (\fn1 v ->
            case v of
                ClientNote v1 ->
                    fn1 v1
        )
        |> Codec.variant1 "ClientNote" ClientNote Codec.string
        |> Codec.buildCustom



--


type alias Billing =
    { address : Maybe ElmShop.Document.Utils.Address.Address
    , note : BillingNote
    }


billingCodec : Codec.Codec Billing
billingCodec =
    Codec.object Billing
        |> Codec.field "address" .address (Codec.maybe ElmShop.Document.Utils.Address.codec)
        |> Codec.field "note" .note billingNoteCodec
        |> Codec.buildObject



--


type BillingNote
    = BillingNote String


billingNoteCodec : Codec.Codec BillingNote
billingNoteCodec =
    Codec.custom
        (\fn1 v ->
            case v of
                BillingNote v1 ->
                    fn1 v1
        )
        |> Codec.variant1 "BillingNote" BillingNote Codec.string
        |> Codec.buildCustom



--


type alias Currency =
    { id : Reference.Reference ElmShop.Document.Type.Currency
    , value : ElmShop.Document.Utils.Money.Money
    }


currencyCodec : Codec.Codec Currency
currencyCodec =
    Codec.object Currency
        |> Codec.field "id" .id Reference.codec
        |> Codec.field "value" .value ElmShop.Document.Utils.Money.codec
        |> Codec.buildObject



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


cartItemCodec : Codec.Codec CartItem
cartItemCodec =
    Codec.object CartItem
        |> Codec.field "created" .created Time.Codec.posix
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "price" .price ElmShop.Document.Utils.Money.codec
        |> Codec.field "quantity" .quantity ElmShop.Document.Utils.Quantity.codec
        |> Codec.field "type_" .type_ cartItemTypeCodec
        |> Codec.buildObject



--


type CartItemType
    = ProductCartItem (Reference.Reference ElmShop.Document.Type.Product) (Maybe (Reference.Reference ElmShop.Document.Type.Product))


cartItemTypeCodec : Codec.Codec CartItemType
cartItemTypeCodec =
    Codec.custom
        (\fn1 v ->
            case v of
                ProductCartItem v1 v2 ->
                    fn1 v1 v2
        )
        |> Codec.variant2 "ProductCartItem" ProductCartItem Reference.codec (Codec.maybe Reference.codec)
        |> Codec.buildCustom



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


shippingCodec : Codec.Codec Shipping
shippingCodec =
    Codec.object Shipping
        |> Codec.field "created" .created Time.Codec.posix
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "price" .price ElmShop.Document.Utils.Money.codec
        |> Codec.field "address" .address (Codec.maybe ElmShop.Document.Utils.Address.codec)
        |> Codec.field "shipping" .shipping Reference.codec
        |> Codec.buildObject



--


type alias Payment =
    { created : Time.Posix

    --
    , name : ElmShop.Document.Utils.Name.Name
    , price : ElmShop.Document.Utils.Money.Money

    --
    , payment : Reference.Reference ElmShop.Document.Type.Payment
    }


paymentCodec : Codec.Codec Payment
paymentCodec =
    Codec.object Payment
        |> Codec.field "created" .created Time.Codec.posix
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "price" .price ElmShop.Document.Utils.Money.codec
        |> Codec.field "payment" .payment Reference.codec
        |> Codec.buildObject



--


type alias Message =
    { created : Time.Posix

    --
    , status : Maybe (Reference.Reference ElmShop.Document.Type.OrderStatus)
    , content : ElmShop.Document.Utils.Html.Html
    , notification : MessageNotification
    }


messageCodec : Codec.Codec Message
messageCodec =
    Codec.object Message
        |> Codec.field "created" .created Time.Codec.posix
        |> Codec.field "status" .status (Codec.maybe Reference.codec)
        |> Codec.field "content" .content ElmShop.Document.Utils.Html.codec
        |> Codec.field "notification" .notification messageNotificationCodec
        |> Codec.buildObject



--


type MessageNotification
    = NoNotification
    | NotifyClient


messageNotificationCodec : Codec.Codec MessageNotification
messageNotificationCodec =
    Codec.custom
        (\fn1 fn2 v ->
            case v of
                NoNotification ->
                    fn1

                NotifyClient ->
                    fn2
        )
        |> Codec.variant0 "NoNotification" NoNotification
        |> Codec.variant0 "NotifyClient" NotifyClient
        |> Codec.buildCustom

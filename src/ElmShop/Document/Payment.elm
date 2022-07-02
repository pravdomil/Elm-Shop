module ElmShop.Document.Payment exposing (..)

import Codec
import Dict.Any
import Dict.Any.Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.Email
import ElmShop.Document.Utils.Html
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Name
import Id
import Reference


type alias Payment =
    { id : Id.Id ElmShop.Document.Type.Payment
    , meta : ElmShop.Document.Utils.Meta.Meta

    --
    , translations : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Language) Translation
    , type_ : Type
    }



--


type alias Translation =
    { name : ElmShop.Document.Utils.Name.Name
    , content : ElmShop.Document.Utils.Html.Html
    }



--


type Type
    = BankTransfer_ BankTransfer
    | PayPal_ PayPal
    | Comgate_ Comgate



--


type alias BankTransfer =
    { orderStatus : Reference.Reference ElmShop.Document.Type.OrderStatus
    }



--


type alias PayPal =
    { email : ElmShop.Document.Utils.Email.Email
    , test : Bool
    }



--


type alias Comgate =
    { merchantId : String
    , secret : String
    , test : Bool
    }



--


codec : Codec.Codec Payment
codec =
    Codec.object (\x1 x2 x3 x4 -> { id = x1, meta = x2, translations = x3, type_ = x4 })
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "translations" .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field "type_" .type_ typeCodec
        |> Codec.buildObject


comgateCodec : Codec.Codec Comgate
comgateCodec =
    Codec.object (\x1 x2 x3 -> { merchantId = x1, secret = x2, test = x3 })
        |> Codec.field "merchantId" .merchantId Codec.string
        |> Codec.field "secret" .secret Codec.string
        |> Codec.field "test" .test Codec.bool
        |> Codec.buildObject


payPalCodec : Codec.Codec PayPal
payPalCodec =
    Codec.object (\x1 x2 -> { email = x1, test = x2 })
        |> Codec.field "email" .email ElmShop.Document.Utils.Email.codec
        |> Codec.field "test" .test Codec.bool
        |> Codec.buildObject


bankTransferCodec : Codec.Codec BankTransfer
bankTransferCodec =
    Codec.object (\x1 -> { orderStatus = x1 })
        |> Codec.field "orderStatus" .orderStatus Reference.codec
        |> Codec.buildObject


typeCodec : Codec.Codec Type
typeCodec =
    Codec.custom
        (\fn1 fn2 fn3 x ->
            case x of
                BankTransfer_ x1 ->
                    fn1 x1

                PayPal_ x1 ->
                    fn2 x1

                Comgate_ x1 ->
                    fn3 x1
        )
        |> Codec.variant1 "BankTransfer_" BankTransfer_ bankTransferCodec
        |> Codec.variant1 "PayPal_" PayPal_ payPalCodec
        |> Codec.variant1 "Comgate_" Comgate_ comgateCodec
        |> Codec.buildCustom


translationCodec : Codec.Codec Translation
translationCodec =
    Codec.object (\x1 x2 -> { name = x1, content = x2 })
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "content" .content ElmShop.Document.Utils.Html.codec
        |> Codec.buildObject

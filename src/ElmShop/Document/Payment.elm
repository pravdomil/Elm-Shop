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


codec : Codec.Codec Payment
codec =
    Codec.object Payment
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "translations" .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field "type_" .type_ typeCodec
        |> Codec.buildObject



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


type Type
    = BankTransfer_ BankTransfer
    | PayPal_ PayPal
    | Comgate_ Comgate


typeCodec : Codec.Codec Type
typeCodec =
    Codec.custom
        (\fn1 fn2 fn3 v ->
            case v of
                BankTransfer_ v1 ->
                    fn1 v1

                PayPal_ v1 ->
                    fn2 v1

                Comgate_ v1 ->
                    fn3 v1
        )
        |> Codec.variant1 "BankTransfer_" BankTransfer_ bankTransferCodec
        |> Codec.variant1 "PayPal_" PayPal_ payPalCodec
        |> Codec.variant1 "Comgate_" Comgate_ comgateCodec
        |> Codec.buildCustom



--


type alias BankTransfer =
    { orderStatus : Reference.Reference ElmShop.Document.Type.OrderStatus
    }


bankTransferCodec : Codec.Codec BankTransfer
bankTransferCodec =
    Codec.object BankTransfer
        |> Codec.field "orderStatus" .orderStatus Reference.codec
        |> Codec.buildObject



--


type alias PayPal =
    { email : ElmShop.Document.Utils.Email.Email
    , test : Bool
    }


payPalCodec : Codec.Codec PayPal
payPalCodec =
    Codec.object PayPal
        |> Codec.field "email" .email ElmShop.Document.Utils.Email.codec
        |> Codec.field "test" .test Codec.bool
        |> Codec.buildObject



--


type alias Comgate =
    { merchantId : String
    , secret : String
    , test : Bool
    }


comgateCodec : Codec.Codec Comgate
comgateCodec =
    Codec.object Comgate
        |> Codec.field "merchantId" .merchantId Codec.string
        |> Codec.field "secret" .secret Codec.string
        |> Codec.field "test" .test Codec.bool
        |> Codec.buildObject

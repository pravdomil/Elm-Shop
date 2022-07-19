module ElmShop.Document.Payment exposing (..)

import Codec
import Dataman.Schema
import Dataman.Schema.Basics
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
    Codec.record (\x1 x2 x3 x4 -> { id = x1, meta = x2, translations = x3, type_ = x4 })
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "translations" .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field "type_" .type_ typeCodec
        |> Codec.buildRecord


comgateCodec : Codec.Codec Comgate
comgateCodec =
    Codec.record (\x1 x2 x3 -> { merchantId = x1, secret = x2, test = x3 })
        |> Codec.field "merchantId" .merchantId Codec.string
        |> Codec.field "secret" .secret Codec.string
        |> Codec.field "test" .test Codec.bool
        |> Codec.buildRecord


payPalCodec : Codec.Codec PayPal
payPalCodec =
    Codec.record (\x1 x2 -> { email = x1, test = x2 })
        |> Codec.field "email" .email ElmShop.Document.Utils.Email.codec
        |> Codec.field "test" .test Codec.bool
        |> Codec.buildRecord


bankTransferCodec : Codec.Codec BankTransfer
bankTransferCodec =
    Codec.record (\x1 -> { orderStatus = x1 })
        |> Codec.field "orderStatus" .orderStatus Reference.codec
        |> Codec.buildRecord


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
    Codec.record (\x1 x2 -> { name = x1, content = x2 })
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "content" .content ElmShop.Document.Utils.Html.codec
        |> Codec.buildRecord


schema : Dataman.Schema.Schema Payment
schema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Payment" ] "Payment"))
        Nothing
        [ Dataman.Schema.RecordField "id" (Dataman.Schema.toAny (Dataman.Schema.Basics.id ElmShop.Document.Type.paymentSchema))
        , Dataman.Schema.RecordField "meta" (Dataman.Schema.toAny ElmShop.Document.Utils.Meta.schema)
        , Dataman.Schema.RecordField "translations" (Dataman.Schema.toAny (Dataman.Schema.Basics.anyDict (Dataman.Schema.Basics.reference ElmShop.Document.Type.languageSchema) translationSchema))
        , Dataman.Schema.RecordField "type_" (Dataman.Schema.toAny typeSchema)
        ]


translationSchema : Dataman.Schema.Schema Translation
translationSchema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Payment" ] "Translation"))
        Nothing
        [ Dataman.Schema.RecordField "name" (Dataman.Schema.toAny ElmShop.Document.Utils.Name.schema)
        , Dataman.Schema.RecordField "content" (Dataman.Schema.toAny ElmShop.Document.Utils.Html.schema)
        ]


typeSchema : Dataman.Schema.Schema Type
typeSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Payment" ] "Type")
        Nothing
        (Dataman.Schema.Variant "BankTransfer_" [ Dataman.Schema.toAny bankTransferSchema ])
        [ Dataman.Schema.Variant "PayPal_" [ Dataman.Schema.toAny payPalSchema ]
        , Dataman.Schema.Variant "Comgate_" [ Dataman.Schema.toAny comgateSchema ]
        ]


bankTransferSchema : Dataman.Schema.Schema BankTransfer
bankTransferSchema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Payment" ] "BankTransfer"))
        Nothing
        [ Dataman.Schema.RecordField "orderStatus" (Dataman.Schema.toAny (Dataman.Schema.Basics.reference ElmShop.Document.Type.orderStatusSchema))
        ]


payPalSchema : Dataman.Schema.Schema PayPal
payPalSchema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Payment" ] "PayPal"))
        Nothing
        [ Dataman.Schema.RecordField "email" (Dataman.Schema.toAny ElmShop.Document.Utils.Email.schema)
        , Dataman.Schema.RecordField "test" (Dataman.Schema.toAny Dataman.Schema.Basics.bool)
        ]


comgateSchema : Dataman.Schema.Schema Comgate
comgateSchema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Payment" ] "Comgate"))
        Nothing
        [ Dataman.Schema.RecordField "merchantId" (Dataman.Schema.toAny Dataman.Schema.Basics.string)
        , Dataman.Schema.RecordField "secret" (Dataman.Schema.toAny Dataman.Schema.Basics.string)
        , Dataman.Schema.RecordField "test" (Dataman.Schema.toAny Dataman.Schema.Basics.bool)
        ]

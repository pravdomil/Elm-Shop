module ElmShop.Document.Payment exposing (..)

import Codec
import Dataman.Type
import Dict.Any
import Dict.Any.Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.Email
import ElmShop.Document.Utils.Html
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Name
import Reference


type alias Payment =
    { translations : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Language) Translation
    , type_ : Type

    --
    , meta : ElmShop.Document.Utils.Meta.Meta
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
    Codec.record (\x1 x2 x3 -> { translations = x1, type_ = x2, meta = x3 })
        |> Codec.field .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field .type_ typeCodec
        |> Codec.field .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.buildRecord


comgateCodec : Codec.Codec Comgate
comgateCodec =
    Codec.record (\x1 x2 x3 -> { merchantId = x1, secret = x2, test = x3 })
        |> Codec.field .merchantId Codec.string
        |> Codec.field .secret Codec.string
        |> Codec.field .test Codec.bool
        |> Codec.buildRecord


payPalCodec : Codec.Codec PayPal
payPalCodec =
    Codec.record (\x1 x2 -> { email = x1, test = x2 })
        |> Codec.field .email ElmShop.Document.Utils.Email.codec
        |> Codec.field .test Codec.bool
        |> Codec.buildRecord


bankTransferCodec : Codec.Codec BankTransfer
bankTransferCodec =
    Codec.record (\x1 -> { orderStatus = x1 })
        |> Codec.field .orderStatus Reference.codec
        |> Codec.buildRecord


typeCodec : Codec.Codec Type
typeCodec =
    Codec.lazy
        (\() ->
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
                |> Codec.variant1 BankTransfer_ bankTransferCodec
                |> Codec.variant1 PayPal_ payPalCodec
                |> Codec.variant1 Comgate_ comgateCodec
                |> Codec.buildCustom
        )


translationCodec : Codec.Codec Translation
translationCodec =
    Codec.record (\x1 x2 -> { name = x1, content = x2 })
        |> Codec.field .name ElmShop.Document.Utils.Name.codec
        |> Codec.field .content ElmShop.Document.Utils.Html.codec
        |> Codec.buildRecord


type_ : Dataman.Type.Type Payment
type_ =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Payment" ] "Payment")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "translations", type_ = Dataman.Type.toAny (Dataman.Type.anyDict (Dataman.Type.reference ElmShop.Document.Type.languageType) translationType) }
            , { name = Dataman.Type.FieldName "type_", type_ = Dataman.Type.toAny typeType }
            , { name = Dataman.Type.FieldName "meta", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Meta.type_ }
            ]
        }


translationType : Dataman.Type.Type Translation
translationType =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Payment" ] "Translation")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "name", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Name.type_ }
            , { name = Dataman.Type.FieldName "content", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Html.type_ }
            ]
        }


typeType : Dataman.Type.Type Type
typeType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Payment" ] "Type"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "BankTransfer_", arguments = [ Dataman.Type.toAny bankTransferType ] }
            , [ { name = Dataman.Type.VariantName "PayPal_", arguments = [ Dataman.Type.toAny payPalType ] }
              , { name = Dataman.Type.VariantName "Comgate_", arguments = [ Dataman.Type.toAny comgateType ] }
              ]
            )
        }


bankTransferType : Dataman.Type.Type BankTransfer
bankTransferType =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Payment" ] "BankTransfer")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "orderStatus", type_ = Dataman.Type.toAny (Dataman.Type.reference ElmShop.Document.Type.orderStatusType) }
            ]
        }


payPalType : Dataman.Type.Type PayPal
payPalType =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Payment" ] "PayPal")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "email", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Email.type_ }
            , { name = Dataman.Type.FieldName "test", type_ = Dataman.Type.toAny Dataman.Type.bool }
            ]
        }


comgateType : Dataman.Type.Type Comgate
comgateType =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Payment" ] "Comgate")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "merchantId", type_ = Dataman.Type.toAny Dataman.Type.string }
            , { name = Dataman.Type.FieldName "secret", type_ = Dataman.Type.toAny Dataman.Type.string }
            , { name = Dataman.Type.FieldName "test", type_ = Dataman.Type.toAny Dataman.Type.bool }
            ]
        }

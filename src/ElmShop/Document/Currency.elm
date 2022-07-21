module ElmShop.Document.Currency exposing (..)

import Codec
import Dataman.Type
import Dict.Any
import Dict.Any.Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Money
import ElmShop.Document.Utils.Name
import Reference


type alias Currency =
    { name : ElmShop.Document.Utils.Name.Name
    , translations : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Language) Translation
    , code : Code

    --
    , value : ElmShop.Document.Utils.Money.Money
    , decimalPlaces : ElmShop.Document.Utils.Money.DecimalPlaces
    , rounding : Maybe Rounding

    --
    , symbolLeft : String
    , symbolRight : String

    --
    , meta : ElmShop.Document.Utils.Meta.Meta
    }



--


type alias Translation =
    { name : ElmShop.Document.Utils.Name.Name
    }



--


type Code
    = Code String



--


type Rounding
    = Rounding Int



--


codec : Codec.Codec Currency
codec =
    Codec.record (\x1 x2 x3 x4 x5 x6 x7 x8 x9 -> { name = x1, translations = x2, code = x3, value = x4, decimalPlaces = x5, rounding = x6, symbolLeft = x7, symbolRight = x8, meta = x9 })
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "translations" .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field "code" .code codeCodec
        |> Codec.field "value" .value ElmShop.Document.Utils.Money.codec
        |> Codec.field "decimalPlaces" .decimalPlaces ElmShop.Document.Utils.Money.decimalPlacesCodec
        |> Codec.field "rounding" .rounding (Codec.maybe roundingCodec)
        |> Codec.field "symbolLeft" .symbolLeft Codec.string
        |> Codec.field "symbolRight" .symbolRight Codec.string
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.buildRecord


roundingCodec : Codec.Codec Rounding
roundingCodec =
    Codec.lazy
        (\() ->
            Codec.custom
                (\fn1 x ->
                    case x of
                        Rounding x1 ->
                            fn1 x1
                )
                |> Codec.variant1 "Rounding" Rounding Codec.int
                |> Codec.buildCustom
        )


codeCodec : Codec.Codec Code
codeCodec =
    Codec.lazy
        (\() ->
            Codec.custom
                (\fn1 x ->
                    case x of
                        Code x1 ->
                            fn1 x1
                )
                |> Codec.variant1 "Code" Code Codec.string
                |> Codec.buildCustom
        )


translationCodec : Codec.Codec Translation
translationCodec =
    Codec.record (\x1 -> { name = x1 })
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.buildRecord


type_ : Dataman.Type.Type Currency
type_ =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Currency" ] "Currency")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "name", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Name.type_ }
            , { name = Dataman.Type.FieldName "translations", type_ = Dataman.Type.toAny ((\x x2 -> Dataman.Type.AnyDict (Dataman.Type.toAny x) (Dataman.Type.toAny x2) |> Dataman.Type.Opaque_) ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.languageType) translationType) }
            , { name = Dataman.Type.FieldName "code", type_ = Dataman.Type.toAny codeType }
            , { name = Dataman.Type.FieldName "value", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Money.type_ }
            , { name = Dataman.Type.FieldName "decimalPlaces", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Money.decimalPlacesType }
            , { name = Dataman.Type.FieldName "rounding", type_ = Dataman.Type.toAny (Dataman.Type.maybe roundingType) }
            , { name = Dataman.Type.FieldName "symbolLeft", type_ = Dataman.Type.toAny (Dataman.Type.String_ |> Dataman.Type.Opaque_) }
            , { name = Dataman.Type.FieldName "symbolRight", type_ = Dataman.Type.toAny (Dataman.Type.String_ |> Dataman.Type.Opaque_) }
            , { name = Dataman.Type.FieldName "meta", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Meta.type_ }
            ]
        }


translationType : Dataman.Type.Type Translation
translationType =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Currency" ] "Translation")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "name", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Name.type_ }
            ]
        }


codeType : Dataman.Type.Type Code
codeType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Currency" ] "Code"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Code", arguments = [ Dataman.Type.toAny (Dataman.Type.String_ |> Dataman.Type.Opaque_) ] }
            , []
            )
        }


roundingType : Dataman.Type.Type Rounding
roundingType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Currency" ] "Rounding"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Rounding", arguments = [ Dataman.Type.toAny (Dataman.Type.Int_ |> Dataman.Type.Opaque_) ] }
            , []
            )
        }

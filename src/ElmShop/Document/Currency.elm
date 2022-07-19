module ElmShop.Document.Currency exposing (..)

import Codec
import Dataman.Schema
import Dataman.Schema.Basics
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


schema : Dataman.Schema.Schema Currency
schema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Currency" ] "Currency"))
        Nothing
        [ Dataman.Schema.RecordField "name" (Dataman.Schema.toAny ElmShop.Document.Utils.Name.schema)
        , Dataman.Schema.RecordField "translations" (Dataman.Schema.toAny (Dataman.Schema.Basics.anyDict (Dataman.Schema.Basics.reference ElmShop.Document.Type.languageSchema) translationSchema))
        , Dataman.Schema.RecordField "code" (Dataman.Schema.toAny codeSchema)
        , Dataman.Schema.RecordField "value" (Dataman.Schema.toAny ElmShop.Document.Utils.Money.schema)
        , Dataman.Schema.RecordField "decimalPlaces" (Dataman.Schema.toAny ElmShop.Document.Utils.Money.decimalPlacesSchema)
        , Dataman.Schema.RecordField "rounding" (Dataman.Schema.toAny (Dataman.Schema.Basics.maybe roundingSchema))
        , Dataman.Schema.RecordField "symbolLeft" (Dataman.Schema.toAny Dataman.Schema.Basics.string)
        , Dataman.Schema.RecordField "symbolRight" (Dataman.Schema.toAny Dataman.Schema.Basics.string)
        , Dataman.Schema.RecordField "meta" (Dataman.Schema.toAny ElmShop.Document.Utils.Meta.schema)
        ]


translationSchema : Dataman.Schema.Schema Translation
translationSchema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Currency" ] "Translation"))
        Nothing
        [ Dataman.Schema.RecordField "name" (Dataman.Schema.toAny ElmShop.Document.Utils.Name.schema)
        ]


codeSchema : Dataman.Schema.Schema Code
codeSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Currency" ] "Code")
        Nothing
        (Dataman.Schema.Variant "Code" [ Dataman.Schema.toAny Dataman.Schema.Basics.string ])
        []


roundingSchema : Dataman.Schema.Schema Rounding
roundingSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Currency" ] "Rounding")
        Nothing
        (Dataman.Schema.Variant "Rounding" [ Dataman.Schema.toAny Dataman.Schema.Basics.int ])
        []

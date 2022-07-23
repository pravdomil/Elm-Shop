module ElmShop.Document.Country exposing (..)

import Codec
import Dataman.Type
import Dict.Any
import Dict.Any.Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Name
import Reference


type alias Country =
    { name : ElmShop.Document.Utils.Name.Name
    , translations : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Language) Translation
    , code : Code
    , currency : Maybe (Reference.Reference ElmShop.Document.Type.Currency)

    --
    , parent : Maybe (Reference.Reference ElmShop.Document.Type.Country)

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


codec : Codec.Codec Country
codec =
    Codec.record (\x1 x2 x3 x4 x5 x6 -> { name = x1, translations = x2, code = x3, currency = x4, parent = x5, meta = x6 })
        |> Codec.field .name ElmShop.Document.Utils.Name.codec
        |> Codec.field .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field .code codeCodec
        |> Codec.field .currency (Codec.maybe Reference.codec)
        |> Codec.field .parent (Codec.maybe Reference.codec)
        |> Codec.field .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.buildRecord


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
                |> Codec.variant1 Code Codec.string
                |> Codec.buildCustom
        )


translationCodec : Codec.Codec Translation
translationCodec =
    Codec.record (\x1 -> { name = x1 })
        |> Codec.field .name ElmShop.Document.Utils.Name.codec
        |> Codec.buildRecord


type_ : Dataman.Type.Type Country
type_ =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Country" ] "Country")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "name", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Name.type_ }
            , { name = Dataman.Type.FieldName "translations", type_ = Dataman.Type.toAny (Dataman.Type.anyDict (Dataman.Type.reference ElmShop.Document.Type.languageType) translationType) }
            , { name = Dataman.Type.FieldName "code", type_ = Dataman.Type.toAny codeType }
            , { name = Dataman.Type.FieldName "currency", type_ = Dataman.Type.toAny (Dataman.Type.maybe (Dataman.Type.reference ElmShop.Document.Type.currencyType)) }
            , { name = Dataman.Type.FieldName "parent", type_ = Dataman.Type.toAny (Dataman.Type.maybe (Dataman.Type.reference ElmShop.Document.Type.countryType)) }
            , { name = Dataman.Type.FieldName "meta", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Meta.type_ }
            ]
        }


translationType : Dataman.Type.Type Translation
translationType =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Country" ] "Translation")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "name", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Name.type_ }
            ]
        }


codeType : Dataman.Type.Type Code
codeType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Country" ] "Code"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Code", arguments = [ Dataman.Type.toAny Dataman.Type.string ] }
            , []
            )
        }

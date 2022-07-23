module ElmShop.Document.Language exposing (..)

import Codec
import Dataman.Type
import Dict.Any
import Dict.Any.Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Name
import Reference


type alias Language =
    { name : ElmShop.Document.Utils.Name.Name
    , translations : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Language) Translation
    , code : Code

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


codec : Codec.Codec Language
codec =
    Codec.record (\x1 x2 x3 x4 -> { name = x1, translations = x2, code = x3, meta = x4 })
        |> Codec.field .name ElmShop.Document.Utils.Name.codec
        |> Codec.field .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field .code codeCodec
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


type_ : Dataman.Type.Type Language
type_ =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Language" ] "Language")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "name", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Name.type_ }
            , { name = Dataman.Type.FieldName "translations", type_ = Dataman.Type.toAny (Dataman.Type.anyDict (Dataman.Type.reference ElmShop.Document.Type.languageType) translationType) }
            , { name = Dataman.Type.FieldName "code", type_ = Dataman.Type.toAny codeType }
            , { name = Dataman.Type.FieldName "meta", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Meta.type_ }
            ]
        }


translationType : Dataman.Type.Type Translation
translationType =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Language" ] "Translation")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "name", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Name.type_ }
            ]
        }


codeType : Dataman.Type.Type Code
codeType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Language" ] "Code"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Code", arguments = [ Dataman.Type.toAny Dataman.Type.string ] }
            , []
            )
        }

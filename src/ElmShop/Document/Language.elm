module ElmShop.Document.Language exposing (..)

import Codec
import Dataman.Schema
import Dataman.Schema.Basics
import Dict.Any
import Dict.Any.Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Name
import Id
import Reference


type alias Language =
    { id : Id.Id ElmShop.Document.Type.Language
    , meta : ElmShop.Document.Utils.Meta.Meta

    --
    , name : ElmShop.Document.Utils.Name.Name
    , translations : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Language) Translation
    , code : Code
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
    Codec.object (\x1 x2 x3 x4 x5 -> { id = x1, meta = x2, name = x3, translations = x4, code = x5 })
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "translations" .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field "code" .code codeCodec
        |> Codec.buildObject


codeCodec : Codec.Codec Code
codeCodec =
    Codec.custom
        (\fn1 x ->
            case x of
                Code x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "Code" Code Codec.string
        |> Codec.buildCustom


translationCodec : Codec.Codec Translation
translationCodec =
    Codec.object (\x1 -> { name = x1 })
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.buildObject


schema : Dataman.Schema.Schema Language
schema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Language" ] "Language"))
        Nothing
        [ Dataman.Schema.RecordField "id" (Dataman.Schema.toAny (Dataman.Schema.Basics.id ElmShop.Document.Type.languageSchema))
        , Dataman.Schema.RecordField "meta" (Dataman.Schema.toAny ElmShop.Document.Utils.Meta.schema)
        , Dataman.Schema.RecordField "name" (Dataman.Schema.toAny ElmShop.Document.Utils.Name.schema)
        , Dataman.Schema.RecordField "translations" (Dataman.Schema.toAny (Dataman.Schema.Basics.anyDict (Dataman.Schema.Basics.reference ElmShop.Document.Type.languageSchema) translationSchema))
        , Dataman.Schema.RecordField "code" (Dataman.Schema.toAny codeSchema)
        ]


translationSchema : Dataman.Schema.Schema Translation
translationSchema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Language" ] "Translation"))
        Nothing
        [ Dataman.Schema.RecordField "name" (Dataman.Schema.toAny ElmShop.Document.Utils.Name.schema)
        ]


codeSchema : Dataman.Schema.Schema Code
codeSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Language" ] "Code")
        Nothing
        (Dataman.Schema.Variant "Code" [ Dataman.Schema.toAny Dataman.Schema.Basics.string ])
        []

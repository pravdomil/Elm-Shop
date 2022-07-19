module ElmShop.Document.File exposing (..)

import Codec
import Dataman.Schema
import Dataman.Schema.Basics
import Dict.Any
import Dict.Any.Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Name
import Reference


type alias File =
    { name : ElmShop.Document.Utils.Name.Name
    , translations : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Language) Translation
    , url : Url

    --
    , meta : ElmShop.Document.Utils.Meta.Meta
    }



--


type alias Translation =
    { name : ElmShop.Document.Utils.Name.Name
    }



--


type Url
    = Url String



--


codec : Codec.Codec File
codec =
    Codec.record (\x1 x2 x3 x4 -> { name = x1, translations = x2, url = x3, meta = x4 })
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "translations" .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field "url" .url urlCodec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.buildRecord


urlCodec : Codec.Codec Url
urlCodec =
    Codec.lazy
        (\() ->
            Codec.custom
                (\fn1 x ->
                    case x of
                        Url x1 ->
                            fn1 x1
                )
                |> Codec.variant1 "Url" Url Codec.string
                |> Codec.buildCustom
        )


translationCodec : Codec.Codec Translation
translationCodec =
    Codec.record (\x1 -> { name = x1 })
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.buildRecord


schema : Dataman.Schema.Schema File
schema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "File" ] "File"))
        Nothing
        [ Dataman.Schema.RecordField "name" (Dataman.Schema.toAny ElmShop.Document.Utils.Name.schema)
        , Dataman.Schema.RecordField "translations" (Dataman.Schema.toAny (Dataman.Schema.Basics.anyDict (Dataman.Schema.Basics.reference ElmShop.Document.Type.languageSchema) translationSchema))
        , Dataman.Schema.RecordField "url" (Dataman.Schema.toAny urlSchema)
        , Dataman.Schema.RecordField "meta" (Dataman.Schema.toAny ElmShop.Document.Utils.Meta.schema)
        ]


translationSchema : Dataman.Schema.Schema Translation
translationSchema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "File" ] "Translation"))
        Nothing
        [ Dataman.Schema.RecordField "name" (Dataman.Schema.toAny ElmShop.Document.Utils.Name.schema)
        ]


urlSchema : Dataman.Schema.Schema Url
urlSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "File" ] "Url")
        Nothing
        (Dataman.Schema.Variant "Url" [ Dataman.Schema.toAny Dataman.Schema.Basics.string ])
        []

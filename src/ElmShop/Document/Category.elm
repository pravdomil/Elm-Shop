module ElmShop.Document.Category exposing (..)

import Codec
import Dataman.Schema
import Dataman.Schema.Basics
import Dict.Any
import Dict.Any.Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.Html
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Name
import Id
import Reference


type alias Category =
    { id : Id.Id ElmShop.Document.Type.Category
    , meta : ElmShop.Document.Utils.Meta.Meta

    --
    , translations : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Language) Translation
    , parent : Maybe (Reference.Reference ElmShop.Document.Type.Category)
    , image : Maybe (Reference.Reference ElmShop.Document.Type.File)
    }



--


type alias Translation =
    { name : ElmShop.Document.Utils.Name.Name
    , content : ElmShop.Document.Utils.Html.Html
    }



--


codec : Codec.Codec Category
codec =
    Codec.record (\x1 x2 x3 x4 x5 -> { id = x1, meta = x2, translations = x3, parent = x4, image = x5 })
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "translations" .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field "parent" .parent (Codec.maybe Reference.codec)
        |> Codec.field "image" .image (Codec.maybe Reference.codec)
        |> Codec.buildRecord


translationCodec : Codec.Codec Translation
translationCodec =
    Codec.record (\x1 x2 -> { name = x1, content = x2 })
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "content" .content ElmShop.Document.Utils.Html.codec
        |> Codec.buildRecord


schema : Dataman.Schema.Schema Category
schema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Category" ] "Category"))
        Nothing
        [ Dataman.Schema.RecordField "id" (Dataman.Schema.toAny (Dataman.Schema.Basics.id ElmShop.Document.Type.categorySchema))
        , Dataman.Schema.RecordField "meta" (Dataman.Schema.toAny ElmShop.Document.Utils.Meta.schema)
        , Dataman.Schema.RecordField "translations" (Dataman.Schema.toAny (Dataman.Schema.Basics.anyDict (Dataman.Schema.Basics.reference ElmShop.Document.Type.languageSchema) translationSchema))
        , Dataman.Schema.RecordField "parent" (Dataman.Schema.toAny (Dataman.Schema.Basics.maybe (Dataman.Schema.Basics.reference ElmShop.Document.Type.categorySchema)))
        , Dataman.Schema.RecordField "image" (Dataman.Schema.toAny (Dataman.Schema.Basics.maybe (Dataman.Schema.Basics.reference ElmShop.Document.Type.fileSchema)))
        ]


translationSchema : Dataman.Schema.Schema Translation
translationSchema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Category" ] "Translation"))
        Nothing
        [ Dataman.Schema.RecordField "name" (Dataman.Schema.toAny ElmShop.Document.Utils.Name.schema)
        , Dataman.Schema.RecordField "content" (Dataman.Schema.toAny ElmShop.Document.Utils.Html.schema)
        ]

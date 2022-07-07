module ElmShop.Document.Attribute exposing (..)

import Codec
import Codec.Extra
import Dataman.Schema
import Dataman.Schema.Basics
import Dict.Any
import Dict.Any.Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Name
import Id
import Reference


type alias Attribute =
    { id : Id.Id ElmShop.Document.Type.Attribute
    , meta : ElmShop.Document.Utils.Meta.Meta

    --
    , translations : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Language) Translation
    , parent : Maybe (Reference.Reference ElmShop.Document.Type.Attribute)
    , image : Maybe (Reference.Reference ElmShop.Document.Type.File)
    }



--


type alias Translation =
    { name : ElmShop.Document.Utils.Name.Name
    }



--


codec : Codec.Codec Attribute
codec =
    Codec.object (\x1 x2 x3 x4 x5 -> { id = x1, meta = x2, translations = x3, parent = x4, image = x5 })
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "translations" .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field "parent" .parent (Codec.Extra.maybe Reference.codec)
        |> Codec.field "image" .image (Codec.Extra.maybe Reference.codec)
        |> Codec.buildObject


translationCodec : Codec.Codec Translation
translationCodec =
    Codec.object (\x1 -> { name = x1 })
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.buildObject


schema : Dataman.Schema.Schema Attribute
schema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Attribute" ] "Attribute"))
        Nothing
        [ Dataman.Schema.RecordField "id" (Dataman.Schema.toAny (Dataman.Schema.Basics.id ElmShop.Document.Type.attributeSchema))
        , Dataman.Schema.RecordField "meta" (Dataman.Schema.toAny ElmShop.Document.Utils.Meta.schema)
        , Dataman.Schema.RecordField "translations" (Dataman.Schema.toAny (Dataman.Schema.Basics.anyDict (Dataman.Schema.Basics.reference ElmShop.Document.Type.languageSchema) translationSchema))
        , Dataman.Schema.RecordField "parent" (Dataman.Schema.toAny (Dataman.Schema.Basics.maybe (Dataman.Schema.Basics.reference ElmShop.Document.Type.attributeSchema)))
        , Dataman.Schema.RecordField "image" (Dataman.Schema.toAny (Dataman.Schema.Basics.maybe (Dataman.Schema.Basics.reference ElmShop.Document.Type.fileSchema)))
        ]


translationSchema : Dataman.Schema.Schema Translation
translationSchema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Attribute" ] "Translation"))
        Nothing
        [ Dataman.Schema.RecordField "name" (Dataman.Schema.toAny ElmShop.Document.Utils.Name.schema)
        ]

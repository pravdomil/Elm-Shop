module ElmShop.Document.Attribute exposing (..)

import Codec
import Dataman.Type
import Dict.Any
import Dict.Any.Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Name
import Reference


type alias Attribute =
    { translations : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Language) Translation
    , parent : Maybe (Reference.Reference ElmShop.Document.Type.Attribute)
    , image : Maybe (Reference.Reference ElmShop.Document.Type.File)

    --
    , meta : ElmShop.Document.Utils.Meta.Meta
    }



--


type alias Translation =
    { name : ElmShop.Document.Utils.Name.Name
    }



--


codec : Codec.Codec Attribute
codec =
    Codec.record (\x1 x2 x3 x4 -> { translations = x1, parent = x2, image = x3, meta = x4 })
        |> Codec.field "translations" .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field "parent" .parent (Codec.maybe Reference.codec)
        |> Codec.field "image" .image (Codec.maybe Reference.codec)
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.buildRecord


translationCodec : Codec.Codec Translation
translationCodec =
    Codec.record (\x1 -> { name = x1 })
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.buildRecord


type_ : Dataman.Type.Type Attribute
type_ =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Attribute" ] "Attribute")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "translations", type_ = Dataman.Type.toAny ((\x x2 -> Dataman.Type.AnyDict (Dataman.Type.toAny x) (Dataman.Type.toAny x2) |> Dataman.Type.Opaque_) ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.languageType) translationType) }
            , { name = Dataman.Type.FieldName "parent", type_ = Dataman.Type.toAny (Dataman.Type.maybe ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.attributeType)) }
            , { name = Dataman.Type.FieldName "image", type_ = Dataman.Type.toAny (Dataman.Type.maybe ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.fileType)) }
            , { name = Dataman.Type.FieldName "meta", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Meta.type_ }
            ]
        }


translationType : Dataman.Type.Type Translation
translationType =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Attribute" ] "Translation")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "name", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Name.type_ }
            ]
        }

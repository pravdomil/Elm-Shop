module ElmShop.Document.Category exposing (..)

import Codec
import Dataman.Type
import Dict.Any
import Dict.Any.Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.Html
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Name
import Reference


type alias Category =
    { translations : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Language) Translation
    , parent : Maybe (Reference.Reference ElmShop.Document.Type.Category)
    , image : Maybe (Reference.Reference ElmShop.Document.Type.File)

    --
    , meta : ElmShop.Document.Utils.Meta.Meta
    }



--


type alias Translation =
    { name : ElmShop.Document.Utils.Name.Name
    , content : ElmShop.Document.Utils.Html.Html
    }



--


codec : Codec.Codec Category
codec =
    Codec.record (\x1 x2 x3 x4 -> { translations = x1, parent = x2, image = x3, meta = x4 })
        |> Codec.field .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field .parent (Codec.maybe Reference.codec)
        |> Codec.field .image (Codec.maybe Reference.codec)
        |> Codec.field .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.buildRecord


translationCodec : Codec.Codec Translation
translationCodec =
    Codec.record (\x1 x2 -> { name = x1, content = x2 })
        |> Codec.field .name ElmShop.Document.Utils.Name.codec
        |> Codec.field .content ElmShop.Document.Utils.Html.codec
        |> Codec.buildRecord


type_ : Dataman.Type.Type Category
type_ =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Category" ] "Category")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "translations", type_ = Dataman.Type.toAny (Dataman.Type.anyDict (Dataman.Type.reference ElmShop.Document.Type.languageType) translationType) }
            , { name = Dataman.Type.FieldName "parent", type_ = Dataman.Type.toAny (Dataman.Type.maybe (Dataman.Type.reference ElmShop.Document.Type.categoryType)) }
            , { name = Dataman.Type.FieldName "image", type_ = Dataman.Type.toAny (Dataman.Type.maybe (Dataman.Type.reference ElmShop.Document.Type.fileType)) }
            , { name = Dataman.Type.FieldName "meta", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Meta.type_ }
            ]
        }


translationType : Dataman.Type.Type Translation
translationType =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Category" ] "Translation")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "name", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Name.type_ }
            , { name = Dataman.Type.FieldName "content", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Html.type_ }
            ]
        }

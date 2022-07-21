module ElmShop.Document.Warehouse exposing (..)

import Codec
import Dataman.Type
import Dict.Any
import Dict.Any.Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Name
import Reference


type alias Warehouse =
    { translations : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Language) Translation

    --
    , meta : ElmShop.Document.Utils.Meta.Meta
    }



--


type alias Translation =
    { name : ElmShop.Document.Utils.Name.Name
    }



--


codec : Codec.Codec Warehouse
codec =
    Codec.record (\x1 x2 -> { translations = x1, meta = x2 })
        |> Codec.field "translations" .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.buildRecord


translationCodec : Codec.Codec Translation
translationCodec =
    Codec.record (\x1 -> { name = x1 })
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.buildRecord


type_ : Dataman.Type.Type Warehouse
type_ =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Warehouse" ] "Warehouse")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "translations", type_ = Dataman.Type.toAny ((\x x2 -> Dataman.Type.AnyDict (Dataman.Type.toAny x) (Dataman.Type.toAny x2) |> Dataman.Type.Opaque_) ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.languageType) translationType) }
            , { name = Dataman.Type.FieldName "meta", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Meta.type_ }
            ]
        }


translationType : Dataman.Type.Type Translation
translationType =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Warehouse" ] "Translation")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "name", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Name.type_ }
            ]
        }

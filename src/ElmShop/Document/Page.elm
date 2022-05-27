module ElmShop.Document.Page exposing (..)

import Codec
import Dict.Any
import Dict.Any.Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.Html
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Name
import Id
import Reference


type alias Page =
    { id : Id.Id ElmShop.Document.Type.Page
    , meta : ElmShop.Document.Utils.Meta.Meta

    --
    , translations : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Language) Translation
    , parent : Maybe (Reference.Reference ElmShop.Document.Type.Page)
    , image : Maybe (Reference.Reference ElmShop.Document.Type.File)
    }


codec : Codec.Codec Page
codec =
    Codec.object Page
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "translations" .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field "parent" .parent (Codec.maybe Reference.codec)
        |> Codec.field "image" .image (Codec.maybe Reference.codec)
        |> Codec.buildObject



--


type alias Translation =
    { name : ElmShop.Document.Utils.Name.Name
    , content : ElmShop.Document.Utils.Html.Html
    }


translationCodec : Codec.Codec Translation
translationCodec =
    Codec.object Translation
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "content" .content ElmShop.Document.Utils.Html.codec
        |> Codec.buildObject

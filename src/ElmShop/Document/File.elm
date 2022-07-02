module ElmShop.Document.File exposing (..)

import Codec
import Dict.Any
import Dict.Any.Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Name
import Id
import Reference


type alias File =
    { id : Id.Id ElmShop.Document.Type.File
    , meta : ElmShop.Document.Utils.Meta.Meta

    --
    , name : ElmShop.Document.Utils.Name.Name
    , translations : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Language) Translation
    , url : Url
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
    Codec.object (\x1 x2 x3 x4 x5 -> { id = x1, meta = x2, name = x3, translations = x4, url = x5 })
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "translations" .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field "url" .url urlCodec
        |> Codec.buildObject


urlCodec : Codec.Codec Url
urlCodec =
    Codec.custom
        (\fn1 x ->
            case x of
                Url x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "Url" Url Codec.string
        |> Codec.buildCustom


translationCodec : Codec.Codec Translation
translationCodec =
    Codec.object (\x1 -> { name = x1 })
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.buildObject

module ElmShop.Document.Country exposing (..)

import Codec
import Dict.Any
import Dict.Any.Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Name
import Id
import Reference


type alias Country =
    { id : Id.Id ElmShop.Document.Type.Country
    , meta : ElmShop.Document.Utils.Meta.Meta

    --
    , name : ElmShop.Document.Utils.Name.Name
    , translations : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Language) Translation
    , code : Code
    , currency : Maybe (Reference.Reference ElmShop.Document.Type.Currency)

    --
    , parent : Maybe (Reference.Reference ElmShop.Document.Type.Country)
    }



--


type alias Translation =
    { name : ElmShop.Document.Utils.Name.Name
    }



--


type Code
    = Code String



--


codec : Codec.Codec Country
codec =
    Codec.object (\x1 x2 x3 x4 x5 x6 x7 -> { id = x1, meta = x2, name = x3, translations = x4, code = x5, currency = x6, parent = x7 })
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "translations" .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field "code" .code codeCodec
        |> Codec.field "currency" .currency (Codec.maybe Reference.codec)
        |> Codec.field "parent" .parent (Codec.maybe Reference.codec)
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

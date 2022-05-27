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


codec : Codec.Codec Country
codec =
    Codec.object Country
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "translations" .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field "code" .code codeCodec
        |> Codec.field "currency" .currency (Codec.maybe Reference.codec)
        |> Codec.field "parent" .parent (Codec.maybe Reference.codec)
        |> Codec.buildObject



--


type alias Translation =
    { name : ElmShop.Document.Utils.Name.Name
    }


translationCodec : Codec.Codec Translation
translationCodec =
    Codec.object Translation
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.buildObject



--


type Code
    = Code String


codeCodec : Codec.Codec Code
codeCodec =
    Codec.custom
        (\fn1 v ->
            case v of
                Code v1 ->
                    fn1 v1
        )
        |> Codec.variant1 "Code" Code Codec.string
        |> Codec.buildCustom

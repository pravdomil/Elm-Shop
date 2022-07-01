module ElmShop.Document.Message exposing (..)

import Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.Meta
import Id
import Reference


type alias Message =
    { id : Id.Id ElmShop.Document.Type.Message
    , meta : ElmShop.Document.Utils.Meta.Meta

    --
    , type_ : Type
    , message : Content
    , related : List (Reference.Reference ())
    }


codec : Codec.Codec Message
codec =
    Codec.object Message
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "type_" .type_ typeCodec
        |> Codec.field "message" .message contentCodec
        |> Codec.field "related" .related (Codec.list Reference.codec)
        |> Codec.buildObject



--


type Content
    = Content String


contentCodec : Codec.Codec Content
contentCodec =
    Codec.custom
        (\fn1 v ->
            case v of
                Content v1 ->
                    fn1 v1
        )
        |> Codec.variant1 "Content" Content Codec.string
        |> Codec.buildCustom



--


type Type
    = Info
    | Warning
    | Error


typeCodec : Codec.Codec Type
typeCodec =
    Codec.custom
        (\fn1 fn2 fn3 v ->
            case v of
                Info ->
                    fn1

                Warning ->
                    fn2

                Error ->
                    fn3
        )
        |> Codec.variant0 "Info" Info
        |> Codec.variant0 "Warning" Warning
        |> Codec.variant0 "Error" Error
        |> Codec.buildCustom

module ElmShop.Document.Template exposing (..)

import Codec
import Dict.Any
import Dict.Any.Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.Html
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Name
import Id
import Reference


type alias Template =
    { id : Id.Id ElmShop.Document.Type.Template
    , meta : ElmShop.Document.Utils.Meta.Meta

    --
    , name : ElmShop.Document.Utils.Name.Name
    , content : Content
    }



--


type Content
    = Universal { content : ElmShop.Document.Utils.Html.Html }
    | Localized (Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Language) { content : ElmShop.Document.Utils.Html.Html })



--


codec : Codec.Codec Template
codec =
    Codec.object (\x1 x2 x3 x4 -> { id = x1, meta = x2, name = x3, content = x4 })
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "content" .content contentCodec
        |> Codec.buildObject


contentCodec : Codec.Codec Content
contentCodec =
    Codec.custom
        (\fn1 fn2 x ->
            case x of
                Universal x1 ->
                    fn1 x1

                Localized x1 ->
                    fn2 x1
        )
        |> Codec.variant1 "Universal"
            Universal
            (Codec.object (\x1 -> { content = x1 })
                |> Codec.field "content" .content ElmShop.Document.Utils.Html.codec
                |> Codec.buildObject
            )
        |> Codec.variant1 "Localized"
            Localized
            (Dict.Any.Codec.dict Reference.toString
                Reference.codec
                (Codec.object (\x1 -> { content = x1 })
                    |> Codec.field "content" .content ElmShop.Document.Utils.Html.codec
                    |> Codec.buildObject
                )
            )
        |> Codec.buildCustom

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


codec : Codec.Codec Template
codec =
    Codec.object Template
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "content" .content contentCodec
        |> Codec.buildObject



--


type Content
    = Universal { content : ElmShop.Document.Utils.Html.Html }
    | Localized (Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Language) { content : ElmShop.Document.Utils.Html.Html })


contentCodec : Codec.Codec Content
contentCodec =
    Codec.custom
        (\fn1 fn2 v ->
            case v of
                Universal v1 ->
                    fn1 v1

                Localized v1 ->
                    fn2 v1
        )
        |> Codec.variant1 "Universal"
            Universal
            (Codec.object (\v -> { content = v })
                |> Codec.field "content" .content ElmShop.Document.Utils.Html.codec
                |> Codec.buildObject
            )
        |> Codec.variant1 "Localized"
            Localized
            (Dict.Any.Codec.dict Reference.toString
                Reference.codec
                (Codec.object (\v -> { content = v })
                    |> Codec.field "content" .content ElmShop.Document.Utils.Html.codec
                    |> Codec.buildObject
                )
            )
        |> Codec.buildCustom

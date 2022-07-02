module ElmShop.Document.Utils.Html exposing (Html, codec, fromString, toString)

import Codec


type Html
    = Html String


fromString : String -> Html
fromString a =
    Html a


toString : Html -> String
toString (Html a) =
    a


codec : Codec.Codec Html
codec =
    Codec.custom
        (\fn1 x ->
            case x of
                Html x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "Html" Html Codec.string
        |> Codec.buildCustom

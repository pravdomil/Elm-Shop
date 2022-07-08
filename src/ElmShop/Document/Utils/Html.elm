module ElmShop.Document.Utils.Html exposing (Html, codec, fromString, schema, toString)

import Codec
import Dataman.Schema
import Dataman.Schema.Basics


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


schema : Dataman.Schema.Schema Html
schema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Utils", "Html" ] "Html")
        Nothing
        (Dataman.Schema.Variant "Html" [ Dataman.Schema.toAny Dataman.Schema.Basics.string ])
        []

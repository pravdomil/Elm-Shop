module ElmShop.Document.Utils.Text exposing (Text, codec, fromString, schema, toString)

import Codec
import Dataman.Schema
import Dataman.Schema.Basics


type Text
    = Text String


fromString : String -> Text
fromString a =
    Text a


toString : Text -> String
toString (Text a) =
    a


codec : Codec.Codec Text
codec =
    Codec.custom
        (\fn1 x ->
            case x of
                Text x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "Text" Text Codec.string
        |> Codec.buildCustom


schema : Dataman.Schema.Schema Text
schema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Utils", "Text" ] "Text")
        Nothing
        [ Dataman.Schema.Variant "Text" [ Dataman.Schema.toAny Dataman.Schema.Basics.string ]
        ]

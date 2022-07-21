module ElmShop.Document.Utils.Text exposing (Text, codec, fromString, toString, type_)

import Codec
import Dataman.Type


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


type_ : Dataman.Type.Type Text
type_ =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Utils", "Text" ] "Text"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Text", arguments = [ Dataman.Type.toAny (Dataman.Type.String_ |> Dataman.Type.Opaque_) ] }
            , []
            )
        }

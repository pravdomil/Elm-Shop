module ElmShop.Document.Utils.Note exposing (Note, codec, fromString, toString, type_)

import Codec
import Dataman.Type


type Note
    = Note String


fromString : String -> Note
fromString a =
    Note a


toString : Note -> String
toString (Note a) =
    a


codec : Codec.Codec Note
codec =
    Codec.custom
        (\fn1 x ->
            case x of
                Note x1 ->
                    fn1 x1
        )
        |> Codec.variant1 Note Codec.string
        |> Codec.buildCustom


type_ : Dataman.Type.Type Note
type_ =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Utils", "Note" ] "Note"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Note", arguments = [ Dataman.Type.toAny Dataman.Type.string ] }
            , []
            )
        }

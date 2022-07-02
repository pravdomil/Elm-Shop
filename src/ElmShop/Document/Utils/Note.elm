module ElmShop.Document.Utils.Note exposing (Note, codec, fromString, toString)

import Codec


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
        |> Codec.variant1 "Note" Note Codec.string
        |> Codec.buildCustom

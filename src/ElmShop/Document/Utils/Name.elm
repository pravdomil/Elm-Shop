module ElmShop.Document.Utils.Name exposing (Name, codec, default, fromString, schema, toString)

import Codec


type Name
    = Name String


fromString : String -> Maybe Name
fromString a =
    if String.length a > 0 then
        Just (Name a)

    else
        Nothing


toString : Name -> String
toString (Name a) =
    a


default : Name
default =
    Name "Paul"


codec : Codec.Codec Name
codec =
    Codec.string
        |> Codec.andThen
            (\x ->
                case fromString x of
                    Just x2 ->
                        Codec.succeed x2

                    Nothing ->
                        Codec.fail "Cannot decode name."
            )
            toString

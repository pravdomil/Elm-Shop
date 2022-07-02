module ElmShop.Document.Utils.Phone exposing (Phone, codec, fromString, toString)

import Codec


type Phone
    = Phone String


fromString : String -> Maybe Phone
fromString a =
    if String.length a >= 3 then
        Just (Phone a)

    else
        Nothing


toString : Phone -> String
toString (Phone a) =
    a


codec : Codec.Codec Phone
codec =
    Codec.string
        |> Codec.andThen
            (\x ->
                case fromString x of
                    Just x2 ->
                        Codec.succeed x2

                    Nothing ->
                        Codec.fail "Cannot decode phone."
            )
            toString

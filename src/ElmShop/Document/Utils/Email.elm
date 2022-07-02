module ElmShop.Document.Utils.Email exposing (Email, codec, fromString, schema, toString)

import Codec


type Email
    = Email String


fromString : String -> Maybe Email
fromString a =
    if String.length a >= 3 && String.contains "@" a then
        Just (Email a)

    else
        Nothing


toString : Email -> String
toString (Email a) =
    a


codec : Codec.Codec Email
codec =
    Codec.string
        |> Codec.andThen
            (\x ->
                case fromString x of
                    Just x2 ->
                        Codec.succeed x2

                    Nothing ->
                        Codec.fail "Cannot decode e-mail."
            )
            toString

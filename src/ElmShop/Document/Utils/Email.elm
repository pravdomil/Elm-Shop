module ElmShop.Document.Utils.Email exposing (Email, codec, fromString, toString)

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
    Codec.custom
        (\fn1 x ->
            case x of
                Email x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "Email"
            Email
            (Codec.string
                |> Codec.andThen
                    (\x ->
                        case fromString x of
                            Just x2 ->
                                Codec.succeed (toString x2)

                            Nothing ->
                                Codec.fail "Cannot decode e-mail."
                    )
                    identity
            )
        |> Codec.buildCustom

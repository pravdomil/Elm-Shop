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
    Codec.custom
        (\fn1 x ->
            case x of
                Phone x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "Phone"
            Phone
            (Codec.string
                |> Codec.andThen
                    (\x ->
                        case fromString x of
                            Just x2 ->
                                Codec.succeed (toString x2)

                            Nothing ->
                                Codec.fail "Cannot decode phone."
                    )
                    identity
            )
        |> Codec.buildCustom

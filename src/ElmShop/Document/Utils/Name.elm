module ElmShop.Document.Utils.Name exposing (Name, codec, default, fromString, toString)

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
    Codec.custom
        (\fn1 x ->
            case x of
                Name x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "Name"
            Name
            (Codec.string
                |> Codec.andThen
                    (\x ->
                        case fromString x of
                            Just x2 ->
                                Codec.succeed (toString x2)

                            Nothing ->
                                Codec.fail "Cannot decode name."
                    )
                    identity
            )
        |> Codec.buildCustom

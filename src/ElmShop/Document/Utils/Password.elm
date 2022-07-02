module ElmShop.Document.Utils.Password exposing (Password, codec, create, fromString, toString)

import Codec
import Id
import Id.Random
import Task


type Password
    = Password String


create : Task.Task x Password
create =
    Id.Random.generate
        |> Task.map (Id.toString >> Password)


fromString : String -> Maybe Password
fromString a =
    if String.length a >= 25 then
        Just (Password a)

    else
        Nothing


toString : Password -> String
toString (Password a) =
    a


codec : Codec.Codec Password
codec =
    Codec.custom
        (\fn1 x ->
            case x of
                Password x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "Password"
            Password
            (Codec.string
                |> Codec.andThen
                    (\x ->
                        case fromString x of
                            Just x2 ->
                                Codec.succeed (toString x2)

                            Nothing ->
                                Codec.fail "Cannot decode password."
                    )
                    identity
            )
        |> Codec.buildCustom

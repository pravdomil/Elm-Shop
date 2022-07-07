module ElmShop.Document.Utils.Name exposing (Name, codec, default, fromString, schema, toString)

import Codec
import Dataman.Schema
import Dataman.Schema.Basics


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


schema : Dataman.Schema.Schema Name
schema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Utils", "Name" ] "Name")
        Nothing
        [ Dataman.Schema.Variant "Name" [ Dataman.Schema.toAny Dataman.Schema.Basics.string ]
        ]

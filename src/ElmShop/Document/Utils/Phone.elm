module ElmShop.Document.Utils.Phone exposing (Phone, codec, fromString, schema, toString)

import Codec
import Dataman.Schema
import Dataman.Schema.Basics


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
                    identity
                    (\x ->
                        case fromString x of
                            Just x2 ->
                                Codec.succeed (toString x2)

                            Nothing ->
                                Codec.fail "Cannot decode phone."
                    )
            )
        |> Codec.buildCustom


schema : Dataman.Schema.Schema Phone
schema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Utils", "Phone" ] "Phone")
        Nothing
        (Dataman.Schema.Variant "Phone" [ Dataman.Schema.toAny Dataman.Schema.Basics.string ])
        []

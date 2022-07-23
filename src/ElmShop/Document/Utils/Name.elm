module ElmShop.Document.Utils.Name exposing (Name, codec, default, fromString, toString, type_)

import Codec
import Dataman.Type


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
        |> Codec.variant1 Name
            (Codec.string
                |> Codec.andThen
                    identity
                    (\x ->
                        case fromString x of
                            Just x2 ->
                                Codec.succeed (toString x2)

                            Nothing ->
                                Codec.fail "Cannot decode name."
                    )
            )
        |> Codec.buildCustom


type_ : Dataman.Type.Type Name
type_ =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Utils", "Name" ] "Name"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Name", arguments = [ Dataman.Type.toAny Dataman.Type.string ] }
            , []
            )
        }

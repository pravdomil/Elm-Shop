module ElmShop.Document.Utils.Phone exposing (Phone, codec, fromString, toString, type_)

import Codec
import Dataman.Type


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
        |> Codec.variant1 Phone
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


type_ : Dataman.Type.Type Phone
type_ =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Utils", "Phone" ] "Phone"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Phone", arguments = [ Dataman.Type.toAny (Dataman.Type.String_ |> Dataman.Type.Opaque_) ] }
            , []
            )
        }

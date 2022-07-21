module ElmShop.Document.Utils.Html exposing (Html, codec, fromString, toString, type_)

import Codec
import Dataman.Type


type Html
    = Html String


fromString : String -> Html
fromString a =
    Html a


toString : Html -> String
toString (Html a) =
    a


codec : Codec.Codec Html
codec =
    Codec.custom
        (\fn1 x ->
            case x of
                Html x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "Html" Html Codec.string
        |> Codec.buildCustom


type_ : Dataman.Type.Type Html
type_ =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Utils", "Html" ] "Html"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Html", arguments = [ Dataman.Type.toAny (Dataman.Type.String_ |> Dataman.Type.Opaque_) ] }
            , []
            )
        }

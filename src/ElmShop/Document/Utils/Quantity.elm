module ElmShop.Document.Utils.Quantity exposing (Quantity, codec, fromInt, toInt, type_)

import Codec
import Dataman.Type


type Quantity
    = Quantity Int


fromInt : Int -> Maybe Quantity
fromInt a =
    if a > 0 && a < 10000 then
        Just (Quantity a)

    else
        Nothing


toInt : Quantity -> Int
toInt (Quantity a) =
    a


codec : Codec.Codec Quantity
codec =
    Codec.custom
        (\fn1 x ->
            case x of
                Quantity x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "Quantity"
            Quantity
            (Codec.int
                |> Codec.andThen
                    identity
                    (\x ->
                        case fromInt x of
                            Just x2 ->
                                Codec.succeed (toInt x2)

                            Nothing ->
                                Codec.fail "Cannot decode quantity."
                    )
            )
        |> Codec.buildCustom


type_ : Dataman.Type.Type Quantity
type_ =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Utils", "Quantity" ] "Quantity"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Quantity", arguments = [ Dataman.Type.toAny (Dataman.Type.Int_ |> Dataman.Type.Opaque_) ] }
            , []
            )
        }

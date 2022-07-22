module ElmShop.Document.Utils.Money exposing (DecimalPlaces, Money, codec, decimalPlacesCodec, decimalPlacesToInt, decimalPlacesType, fromInt, intToDecimalPlaces, toInt, type_)

import Codec
import Dataman.Type


type Money
    = Money Int


fromInt : Int -> Money
fromInt =
    Money


toInt : Money -> Int
toInt (Money a) =
    a



--


type DecimalPlaces
    = DecimalPlaces Int


intToDecimalPlaces : Int -> Maybe DecimalPlaces
intToDecimalPlaces a =
    if a >= 0 && a < 100 then
        Just (DecimalPlaces a)

    else
        Nothing


decimalPlacesToInt : DecimalPlaces -> Int
decimalPlacesToInt (DecimalPlaces a) =
    a



--


decimalPlacesCodec : Codec.Codec DecimalPlaces
decimalPlacesCodec =
    Codec.custom
        (\fn1 x ->
            case x of
                DecimalPlaces x1 ->
                    fn1 x1
        )
        |> Codec.variant1 DecimalPlaces
            (Codec.int
                |> Codec.andThen
                    identity
                    (\x ->
                        case intToDecimalPlaces x of
                            Just x2 ->
                                Codec.succeed (decimalPlacesToInt x2)

                            Nothing ->
                                Codec.fail "Cannot decode decimal places."
                    )
            )
        |> Codec.buildCustom


codec : Codec.Codec Money
codec =
    Codec.lazy
        (\() ->
            Codec.custom
                (\fn1 x ->
                    case x of
                        Money x1 ->
                            fn1 x1
                )
                |> Codec.variant1 Money Codec.int
                |> Codec.buildCustom
        )


type_ : Dataman.Type.Type Money
type_ =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Utils", "Money" ] "Money"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Money", arguments = [ Dataman.Type.toAny (Dataman.Type.Int_ |> Dataman.Type.Opaque_) ] }
            , []
            )
        }


decimalPlacesType : Dataman.Type.Type DecimalPlaces
decimalPlacesType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Utils", "Money" ] "DecimalPlaces"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "DecimalPlaces", arguments = [ Dataman.Type.toAny (Dataman.Type.Int_ |> Dataman.Type.Opaque_) ] }
            , []
            )
        }

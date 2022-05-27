module ElmShop.Document.Currency exposing (..)

import Codec
import Dict.Any
import Dict.Any.Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Money
import ElmShop.Document.Utils.Name
import Id
import Reference


type alias Currency =
    { id : Id.Id ElmShop.Document.Type.Currency
    , meta : ElmShop.Document.Utils.Meta.Meta

    --
    , name : ElmShop.Document.Utils.Name.Name
    , translations : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Language) Translation
    , code : Code

    --
    , value : ElmShop.Document.Utils.Money.Money
    , decimalPlaces : ElmShop.Document.Utils.Money.DecimalPlaces
    , rounding : Maybe Rounding

    --
    , symbolLeft : String
    , symbolRight : String
    }


codec : Codec.Codec Currency
codec =
    Codec.object Currency
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "translations" .translations (Dict.Any.Codec.dict Reference.toString Reference.codec translationCodec)
        |> Codec.field "code" .code codeCodec
        |> Codec.field "value" .value ElmShop.Document.Utils.Money.codec
        |> Codec.field "decimalPlaces" .decimalPlaces ElmShop.Document.Utils.Money.decimalPlacesCodec
        |> Codec.field "rounding" .rounding (Codec.maybe roundingCodec)
        |> Codec.field "symbolLeft" .symbolLeft Codec.string
        |> Codec.field "symbolRight" .symbolRight Codec.string
        |> Codec.buildObject



--


type alias Translation =
    { name : ElmShop.Document.Utils.Name.Name
    }


translationCodec : Codec.Codec Translation
translationCodec =
    Codec.object Translation
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.buildObject



--


type Code
    = Code String


codeCodec : Codec.Codec Code
codeCodec =
    Codec.custom
        (\fn1 v ->
            case v of
                Code v1 ->
                    fn1 v1
        )
        |> Codec.variant1 "Code" Code Codec.string
        |> Codec.buildCustom



--


type Rounding
    = Rounding Int


roundingCodec : Codec.Codec Rounding
roundingCodec =
    Codec.custom
        (\fn1 x ->
            case x of
                Rounding x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "Rounding" Rounding Codec.int
        |> Codec.buildCustom

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



--


type alias Translation =
    { name : ElmShop.Document.Utils.Name.Name
    }



--


type Code
    = Code String



--


type Rounding
    = Rounding Int



--


codec : Codec.Codec Currency
codec =
    Codec.object (\x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 -> { id = x1, meta = x2, name = x3, translations = x4, code = x5, value = x6, decimalPlaces = x7, rounding = x8, symbolLeft = x9, symbolRight = x10 })
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


codeCodec : Codec.Codec Code
codeCodec =
    Codec.custom
        (\fn1 x ->
            case x of
                Code x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "Code" Code Codec.string
        |> Codec.buildCustom


translationCodec : Codec.Codec Translation
translationCodec =
    Codec.object (\x1 -> { name = x1 })
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.buildObject

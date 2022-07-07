module ElmShop.Document.Utils.CountryFilter exposing (..)

import Codec
import Dataman.Schema
import Dataman.Schema.Basics
import Dict.Any
import Dict.Any.Codec
import ElmShop.Document.Type
import Reference


type CountryFilter
    = Allow (Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Country) ())
    | Deny (Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Country) ())


codec : Codec.Codec CountryFilter
codec =
    Codec.custom
        (\fn1 fn2 x ->
            case x of
                Allow x1 ->
                    fn1 x1

                Deny x1 ->
                    fn2 x1
        )
        |> Codec.variant1 "Allow" Allow (Dict.Any.Codec.dict Reference.toString Reference.codec (Codec.succeed ()))
        |> Codec.variant1 "Deny" Deny (Dict.Any.Codec.dict Reference.toString Reference.codec (Codec.succeed ()))
        |> Codec.buildCustom


schema : Dataman.Schema.Schema CountryFilter
schema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Utils", "CountryFilter" ] "CountryFilter")
        Nothing
        [ Dataman.Schema.Variant "Allow" [ Dataman.Schema.toAny (Dataman.Schema.Basics.anyDict (Dataman.Schema.Basics.reference ElmShop.Document.Type.countrySchema) (Dataman.Schema.Tuple Nothing Nothing [])) ]
        , Dataman.Schema.Variant "Deny" [ Dataman.Schema.toAny (Dataman.Schema.Basics.anyDict (Dataman.Schema.Basics.reference ElmShop.Document.Type.countrySchema) (Dataman.Schema.Tuple Nothing Nothing [])) ]
        ]

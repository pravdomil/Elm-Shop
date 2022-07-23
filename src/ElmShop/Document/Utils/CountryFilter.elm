module ElmShop.Document.Utils.CountryFilter exposing (..)

import Codec
import Dataman.Type
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
        |> Codec.variant1 Allow (Dict.Any.Codec.dict Reference.toString Reference.codec (Codec.succeed ()))
        |> Codec.variant1 Deny (Dict.Any.Codec.dict Reference.toString Reference.codec (Codec.succeed ()))
        |> Codec.buildCustom


type_ : Dataman.Type.Type CountryFilter
type_ =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Utils", "CountryFilter" ] "CountryFilter"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Allow", arguments = [ Dataman.Type.toAny (Dataman.Type.anyDict (Dataman.Type.reference ElmShop.Document.Type.countryType) (Dataman.Type.Tuple_ { name = Nothing, documentation = Nothing, arguments = [] })) ] }
            , [ { name = Dataman.Type.VariantName "Deny", arguments = [ Dataman.Type.toAny (Dataman.Type.anyDict (Dataman.Type.reference ElmShop.Document.Type.countryType) (Dataman.Type.Tuple_ { name = Nothing, documentation = Nothing, arguments = [] })) ] }
              ]
            )
        }

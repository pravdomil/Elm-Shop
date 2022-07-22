module ElmShop.Document.Utils.Address exposing (..)

import Codec
import Dataman.Type
import ElmShop.Document.Type
import Reference


{-| More information:
<https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fe-autocomplete-organization>
<https://developers.google.com/web/updates/2015/06/checkout-faster-with-autofill#address>
<https://developers.google.com/web/fundamentals/design-and-ux/input/forms#recommended_input_name_and_autocomplete_attribute_values>
-}
type alias Address =
    { name : String
    , organization : String
    , address1 : String
    , address2 : String
    , city : String
    , postcode : String
    , state : Reference.Reference ElmShop.Document.Type.Country
    }


codec : Codec.Codec Address
codec =
    Codec.record (\x1 x2 x3 x4 x5 x6 x7 -> { name = x1, organization = x2, address1 = x3, address2 = x4, city = x5, postcode = x6, state = x7 })
        |> Codec.field .name Codec.string
        |> Codec.field .organization Codec.string
        |> Codec.field .address1 Codec.string
        |> Codec.field .address2 Codec.string
        |> Codec.field .city Codec.string
        |> Codec.field .postcode Codec.string
        |> Codec.field .state Reference.codec
        |> Codec.buildRecord


type_ : Dataman.Type.Type Address
type_ =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Utils", "Address" ] "Address")
        , documentation = Just (Dataman.Type.Documentation "More information:\\n<https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fe-autocomplete-organization>\\n<https://developers.google.com/web/updates/2015/06/checkout-faster-with-autofill#address>\\n<https://developers.google.com/web/fundamentals/design-and-ux/input/forms#recommended_input_name_and_autocomplete_attribute_values>")
        , fields =
            [ { name = Dataman.Type.FieldName "name", type_ = Dataman.Type.toAny (Dataman.Type.String_ |> Dataman.Type.Opaque_) }
            , { name = Dataman.Type.FieldName "organization", type_ = Dataman.Type.toAny (Dataman.Type.String_ |> Dataman.Type.Opaque_) }
            , { name = Dataman.Type.FieldName "address1", type_ = Dataman.Type.toAny (Dataman.Type.String_ |> Dataman.Type.Opaque_) }
            , { name = Dataman.Type.FieldName "address2", type_ = Dataman.Type.toAny (Dataman.Type.String_ |> Dataman.Type.Opaque_) }
            , { name = Dataman.Type.FieldName "city", type_ = Dataman.Type.toAny (Dataman.Type.String_ |> Dataman.Type.Opaque_) }
            , { name = Dataman.Type.FieldName "postcode", type_ = Dataman.Type.toAny (Dataman.Type.String_ |> Dataman.Type.Opaque_) }
            , { name = Dataman.Type.FieldName "state", type_ = Dataman.Type.toAny ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.countryType) }
            ]
        }

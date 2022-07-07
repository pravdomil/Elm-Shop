module ElmShop.Document.Utils.Address exposing (..)

import Codec
import Dataman.Schema
import Dataman.Schema.Basics
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
    Codec.object (\x1 x2 x3 x4 x5 x6 x7 -> { name = x1, organization = x2, address1 = x3, address2 = x4, city = x5, postcode = x6, state = x7 })
        |> Codec.field "name" .name Codec.string
        |> Codec.field "organization" .organization Codec.string
        |> Codec.field "address1" .address1 Codec.string
        |> Codec.field "address2" .address2 Codec.string
        |> Codec.field "city" .city Codec.string
        |> Codec.field "postcode" .postcode Codec.string
        |> Codec.field "state" .state Reference.codec
        |> Codec.buildObject


schema : Dataman.Schema.Schema Address
schema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Utils", "Address" ] "Address"))
        (Just (Dataman.Schema.Documentation "More information:\\n<https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fe-autocomplete-organization>\\n<https://developers.google.com/web/updates/2015/06/checkout-faster-with-autofill#address>\\n<https://developers.google.com/web/fundamentals/design-and-ux/input/forms#recommended_input_name_and_autocomplete_attribute_values>"))
        [ Dataman.Schema.RecordField "name" (Dataman.Schema.toAny Dataman.Schema.Basics.string)
        , Dataman.Schema.RecordField "organization" (Dataman.Schema.toAny Dataman.Schema.Basics.string)
        , Dataman.Schema.RecordField "address1" (Dataman.Schema.toAny Dataman.Schema.Basics.string)
        , Dataman.Schema.RecordField "address2" (Dataman.Schema.toAny Dataman.Schema.Basics.string)
        , Dataman.Schema.RecordField "city" (Dataman.Schema.toAny Dataman.Schema.Basics.string)
        , Dataman.Schema.RecordField "postcode" (Dataman.Schema.toAny Dataman.Schema.Basics.string)
        , Dataman.Schema.RecordField "state" (Dataman.Schema.toAny (Dataman.Schema.Basics.reference ElmShop.Document.Type.countrySchema))
        ]

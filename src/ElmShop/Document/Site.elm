module ElmShop.Document.Site exposing (..)

import Codec
import Dict.Any
import Dict.Any.Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.Address
import ElmShop.Document.Utils.Email
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Name
import ElmShop.Document.Utils.Note
import ElmShop.Document.Utils.Order
import ElmShop.Document.Utils.Phone
import Id
import Reference


type alias Site =
    { id : Id.Id ElmShop.Document.Type.Site
    , meta : ElmShop.Document.Utils.Meta.Meta

    --
    , name : ElmShop.Document.Utils.Name.Name
    , url : Url
    , description : Description

    --
    , contact : Contact

    --
    , language : Reference.Reference ElmShop.Document.Type.Language
    , homePage : Reference.Reference ElmShop.Document.Type.Page
    , currency : Reference.Reference ElmShop.Document.Type.Currency

    --
    , logo : Maybe (Reference.Reference ElmShop.Document.Type.File)
    , icon : Maybe (Reference.Reference ElmShop.Document.Type.File)

    --
    , header : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Page) { order : ElmShop.Document.Utils.Order.Order }
    , footer : Dict.Any.Dict (Reference.Reference ElmShop.Document.Type.Page) { order : ElmShop.Document.Utils.Order.Order }
    }


codec : Codec.Codec Site
codec =
    Codec.object Site
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "url" .url urlCodec
        |> Codec.field "description" .description descriptionCodec
        |> Codec.field "contact" .contact contactCodec
        |> Codec.field "language" .language Reference.codec
        |> Codec.field "homePage" .homePage Reference.codec
        |> Codec.field "currency" .currency Reference.codec
        |> Codec.field "logo" .logo (Codec.maybe Reference.codec)
        |> Codec.field "icon" .icon (Codec.maybe Reference.codec)
        |> Codec.field "header"
            .header
            (Dict.Any.Codec.dict Reference.toString
                Reference.codec
                (Codec.object (\v -> { order = v })
                    |> Codec.field "order" .order ElmShop.Document.Utils.Order.codec
                    |> Codec.buildObject
                )
            )
        |> Codec.field "footer"
            .footer
            (Dict.Any.Codec.dict Reference.toString
                Reference.codec
                (Codec.object (\v -> { order = v })
                    |> Codec.field "order" .order ElmShop.Document.Utils.Order.codec
                    |> Codec.buildObject
                )
            )
        |> Codec.buildObject



--


type Url
    = Url String


urlCodec : Codec.Codec Url
urlCodec =
    Codec.custom
        (\fn1 x ->
            case x of
                Url x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "Url" Url Codec.string
        |> Codec.buildCustom



--


type Description
    = Description String


descriptionCodec : Codec.Codec Description
descriptionCodec =
    Codec.custom
        (\fn1 v ->
            case v of
                Description v1 ->
                    fn1 v1
        )
        |> Codec.variant1 "Description" Description Codec.string
        |> Codec.buildCustom



--


type alias Contact =
    { email : Maybe ElmShop.Document.Utils.Email.Email
    , phone : Maybe ElmShop.Document.Utils.Phone.Phone
    , note : ElmShop.Document.Utils.Note.Note
    , address : Maybe ElmShop.Document.Utils.Address.Address
    }


contactCodec : Codec.Codec Contact
contactCodec =
    Codec.object Contact
        |> Codec.field "email" .email (Codec.maybe ElmShop.Document.Utils.Email.codec)
        |> Codec.field "phone" .phone (Codec.maybe ElmShop.Document.Utils.Phone.codec)
        |> Codec.field "note" .note ElmShop.Document.Utils.Note.codec
        |> Codec.field "address" .address (Codec.maybe ElmShop.Document.Utils.Address.codec)
        |> Codec.buildObject

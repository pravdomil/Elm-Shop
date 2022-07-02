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



--


type Url
    = Url String



--


type Description
    = Description String



--


type alias Contact =
    { email : Maybe ElmShop.Document.Utils.Email.Email
    , phone : Maybe ElmShop.Document.Utils.Phone.Phone
    , note : ElmShop.Document.Utils.Note.Note
    , address : Maybe ElmShop.Document.Utils.Address.Address
    }



--


codec : Codec.Codec Site
codec =
    Codec.object (\x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 -> { id = x1, meta = x2, name = x3, url = x4, description = x5, contact = x6, language = x7, homePage = x8, currency = x9, logo = x10, icon = x11, header = x12, footer = x13 })
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
                (Codec.object (\x1 -> { order = x1 })
                    |> Codec.field "order" .order ElmShop.Document.Utils.Order.codec
                    |> Codec.buildObject
                )
            )
        |> Codec.field "footer"
            .footer
            (Dict.Any.Codec.dict Reference.toString
                Reference.codec
                (Codec.object (\x1 -> { order = x1 })
                    |> Codec.field "order" .order ElmShop.Document.Utils.Order.codec
                    |> Codec.buildObject
                )
            )
        |> Codec.buildObject


contactCodec : Codec.Codec Contact
contactCodec =
    Codec.object (\x1 x2 x3 x4 -> { email = x1, phone = x2, note = x3, address = x4 })
        |> Codec.field "email" .email (Codec.maybe ElmShop.Document.Utils.Email.codec)
        |> Codec.field "phone" .phone (Codec.maybe ElmShop.Document.Utils.Phone.codec)
        |> Codec.field "note" .note ElmShop.Document.Utils.Note.codec
        |> Codec.field "address" .address (Codec.maybe ElmShop.Document.Utils.Address.codec)
        |> Codec.buildObject


descriptionCodec : Codec.Codec Description
descriptionCodec =
    Codec.custom
        (\fn1 x ->
            case x of
                Description x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "Description" Description Codec.string
        |> Codec.buildCustom


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

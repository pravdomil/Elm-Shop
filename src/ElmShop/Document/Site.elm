module ElmShop.Document.Site exposing (..)

import Codec
import Dataman.Schema
import Dataman.Schema.Basics
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
import Reference


type alias Site =
    { name : ElmShop.Document.Utils.Name.Name
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

    --
    , meta : ElmShop.Document.Utils.Meta.Meta
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
    Codec.record (\x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 -> { name = x1, url = x2, description = x3, contact = x4, language = x5, homePage = x6, currency = x7, logo = x8, icon = x9, header = x10, footer = x11, meta = x12 })
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
                (Codec.record (\x1 -> { order = x1 })
                    |> Codec.field "order" .order ElmShop.Document.Utils.Order.codec
                    |> Codec.buildRecord
                )
            )
        |> Codec.field "footer"
            .footer
            (Dict.Any.Codec.dict Reference.toString
                Reference.codec
                (Codec.record (\x1 -> { order = x1 })
                    |> Codec.field "order" .order ElmShop.Document.Utils.Order.codec
                    |> Codec.buildRecord
                )
            )
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.buildRecord


contactCodec : Codec.Codec Contact
contactCodec =
    Codec.record (\x1 x2 x3 x4 -> { email = x1, phone = x2, note = x3, address = x4 })
        |> Codec.field "email" .email (Codec.maybe ElmShop.Document.Utils.Email.codec)
        |> Codec.field "phone" .phone (Codec.maybe ElmShop.Document.Utils.Phone.codec)
        |> Codec.field "note" .note ElmShop.Document.Utils.Note.codec
        |> Codec.field "address" .address (Codec.maybe ElmShop.Document.Utils.Address.codec)
        |> Codec.buildRecord


descriptionCodec : Codec.Codec Description
descriptionCodec =
    Codec.lazy
        (\() ->
            Codec.custom
                (\fn1 x ->
                    case x of
                        Description x1 ->
                            fn1 x1
                )
                |> Codec.variant1 "Description" Description Codec.string
                |> Codec.buildCustom
        )


urlCodec : Codec.Codec Url
urlCodec =
    Codec.lazy
        (\() ->
            Codec.custom
                (\fn1 x ->
                    case x of
                        Url x1 ->
                            fn1 x1
                )
                |> Codec.variant1 "Url" Url Codec.string
                |> Codec.buildCustom
        )


schema : Dataman.Schema.Schema Site
schema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Site" ] "Site"))
        Nothing
        [ Dataman.Schema.RecordField "name" (Dataman.Schema.toAny ElmShop.Document.Utils.Name.schema)
        , Dataman.Schema.RecordField "url" (Dataman.Schema.toAny urlSchema)
        , Dataman.Schema.RecordField "description" (Dataman.Schema.toAny descriptionSchema)
        , Dataman.Schema.RecordField "contact" (Dataman.Schema.toAny contactSchema)
        , Dataman.Schema.RecordField "language" (Dataman.Schema.toAny (Dataman.Schema.Basics.reference ElmShop.Document.Type.languageSchema))
        , Dataman.Schema.RecordField "homePage" (Dataman.Schema.toAny (Dataman.Schema.Basics.reference ElmShop.Document.Type.pageSchema))
        , Dataman.Schema.RecordField "currency" (Dataman.Schema.toAny (Dataman.Schema.Basics.reference ElmShop.Document.Type.currencySchema))
        , Dataman.Schema.RecordField "logo" (Dataman.Schema.toAny (Dataman.Schema.Basics.maybe (Dataman.Schema.Basics.reference ElmShop.Document.Type.fileSchema)))
        , Dataman.Schema.RecordField "icon" (Dataman.Schema.toAny (Dataman.Schema.Basics.maybe (Dataman.Schema.Basics.reference ElmShop.Document.Type.fileSchema)))
        , Dataman.Schema.RecordField "header"
            (Dataman.Schema.toAny
                (Dataman.Schema.Basics.anyDict (Dataman.Schema.Basics.reference ElmShop.Document.Type.pageSchema)
                    (Dataman.Schema.Record Nothing
                        Nothing
                        [ Dataman.Schema.RecordField "order" (Dataman.Schema.toAny ElmShop.Document.Utils.Order.schema)
                        ]
                    )
                )
            )
        , Dataman.Schema.RecordField "footer"
            (Dataman.Schema.toAny
                (Dataman.Schema.Basics.anyDict (Dataman.Schema.Basics.reference ElmShop.Document.Type.pageSchema)
                    (Dataman.Schema.Record Nothing
                        Nothing
                        [ Dataman.Schema.RecordField "order" (Dataman.Schema.toAny ElmShop.Document.Utils.Order.schema)
                        ]
                    )
                )
            )
        , Dataman.Schema.RecordField "meta" (Dataman.Schema.toAny ElmShop.Document.Utils.Meta.schema)
        ]


urlSchema : Dataman.Schema.Schema Url
urlSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Site" ] "Url")
        Nothing
        (Dataman.Schema.Variant "Url" [ Dataman.Schema.toAny Dataman.Schema.Basics.string ])
        []


descriptionSchema : Dataman.Schema.Schema Description
descriptionSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Site" ] "Description")
        Nothing
        (Dataman.Schema.Variant "Description" [ Dataman.Schema.toAny Dataman.Schema.Basics.string ])
        []


contactSchema : Dataman.Schema.Schema Contact
contactSchema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Site" ] "Contact"))
        Nothing
        [ Dataman.Schema.RecordField "email" (Dataman.Schema.toAny (Dataman.Schema.Basics.maybe ElmShop.Document.Utils.Email.schema))
        , Dataman.Schema.RecordField "phone" (Dataman.Schema.toAny (Dataman.Schema.Basics.maybe ElmShop.Document.Utils.Phone.schema))
        , Dataman.Schema.RecordField "note" (Dataman.Schema.toAny ElmShop.Document.Utils.Note.schema)
        , Dataman.Schema.RecordField "address" (Dataman.Schema.toAny (Dataman.Schema.Basics.maybe ElmShop.Document.Utils.Address.schema))
        ]

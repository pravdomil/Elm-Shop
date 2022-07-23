module ElmShop.Document.Site exposing (..)

import Codec
import Dataman.Type
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
        |> Codec.field .name ElmShop.Document.Utils.Name.codec
        |> Codec.field .url urlCodec
        |> Codec.field .description descriptionCodec
        |> Codec.field .contact contactCodec
        |> Codec.field .language Reference.codec
        |> Codec.field .homePage Reference.codec
        |> Codec.field .currency Reference.codec
        |> Codec.field .logo (Codec.maybe Reference.codec)
        |> Codec.field .icon (Codec.maybe Reference.codec)
        |> Codec.field
            .header
            (Dict.Any.Codec.dict Reference.toString
                Reference.codec
                (Codec.record (\x1 -> { order = x1 })
                    |> Codec.field .order ElmShop.Document.Utils.Order.codec
                    |> Codec.buildRecord
                )
            )
        |> Codec.field
            .footer
            (Dict.Any.Codec.dict Reference.toString
                Reference.codec
                (Codec.record (\x1 -> { order = x1 })
                    |> Codec.field .order ElmShop.Document.Utils.Order.codec
                    |> Codec.buildRecord
                )
            )
        |> Codec.field .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.buildRecord


contactCodec : Codec.Codec Contact
contactCodec =
    Codec.record (\x1 x2 x3 x4 -> { email = x1, phone = x2, note = x3, address = x4 })
        |> Codec.field .email (Codec.maybe ElmShop.Document.Utils.Email.codec)
        |> Codec.field .phone (Codec.maybe ElmShop.Document.Utils.Phone.codec)
        |> Codec.field .note ElmShop.Document.Utils.Note.codec
        |> Codec.field .address (Codec.maybe ElmShop.Document.Utils.Address.codec)
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
                |> Codec.variant1 Description Codec.string
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
                |> Codec.variant1 Url Codec.string
                |> Codec.buildCustom
        )


type_ : Dataman.Type.Type Site
type_ =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Site" ] "Site")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "name", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Name.type_ }
            , { name = Dataman.Type.FieldName "url", type_ = Dataman.Type.toAny urlType }
            , { name = Dataman.Type.FieldName "description", type_ = Dataman.Type.toAny descriptionType }
            , { name = Dataman.Type.FieldName "contact", type_ = Dataman.Type.toAny contactType }
            , { name = Dataman.Type.FieldName "language", type_ = Dataman.Type.toAny (Dataman.Type.reference ElmShop.Document.Type.languageType) }
            , { name = Dataman.Type.FieldName "homePage", type_ = Dataman.Type.toAny (Dataman.Type.reference ElmShop.Document.Type.pageType) }
            , { name = Dataman.Type.FieldName "currency", type_ = Dataman.Type.toAny (Dataman.Type.reference ElmShop.Document.Type.currencyType) }
            , { name = Dataman.Type.FieldName "logo", type_ = Dataman.Type.toAny (Dataman.Type.maybe (Dataman.Type.reference ElmShop.Document.Type.fileType)) }
            , { name = Dataman.Type.FieldName "icon", type_ = Dataman.Type.toAny (Dataman.Type.maybe (Dataman.Type.reference ElmShop.Document.Type.fileType)) }
            , { name = Dataman.Type.FieldName "header"
              , type_ =
                    Dataman.Type.toAny
                        (Dataman.Type.anyDict (Dataman.Type.reference ElmShop.Document.Type.pageType)
                            (Dataman.Type.Record_
                                { name = Nothing
                                , documentation = Nothing
                                , fields =
                                    [ { name = Dataman.Type.FieldName "order", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Order.type_ }
                                    ]
                                }
                            )
                        )
              }
            , { name = Dataman.Type.FieldName "footer"
              , type_ =
                    Dataman.Type.toAny
                        (Dataman.Type.anyDict (Dataman.Type.reference ElmShop.Document.Type.pageType)
                            (Dataman.Type.Record_
                                { name = Nothing
                                , documentation = Nothing
                                , fields =
                                    [ { name = Dataman.Type.FieldName "order", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Order.type_ }
                                    ]
                                }
                            )
                        )
              }
            , { name = Dataman.Type.FieldName "meta", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Meta.type_ }
            ]
        }


urlType : Dataman.Type.Type Url
urlType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Site" ] "Url"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Url", arguments = [ Dataman.Type.toAny Dataman.Type.string ] }
            , []
            )
        }


descriptionType : Dataman.Type.Type Description
descriptionType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Site" ] "Description"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Description", arguments = [ Dataman.Type.toAny Dataman.Type.string ] }
            , []
            )
        }


contactType : Dataman.Type.Type Contact
contactType =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Site" ] "Contact")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "email", type_ = Dataman.Type.toAny (Dataman.Type.maybe ElmShop.Document.Utils.Email.type_) }
            , { name = Dataman.Type.FieldName "phone", type_ = Dataman.Type.toAny (Dataman.Type.maybe ElmShop.Document.Utils.Phone.type_) }
            , { name = Dataman.Type.FieldName "note", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Note.type_ }
            , { name = Dataman.Type.FieldName "address", type_ = Dataman.Type.toAny (Dataman.Type.maybe ElmShop.Document.Utils.Address.type_) }
            ]
        }

module ElmShop.Document.Utils.Meta exposing (..)

import Codec
import Dataman.Schema
import Dataman.Schema.Basics
import ElmShop.Document.Utils.Note
import ElmShop.Document.Utils.Order
import Task
import Task.Extra
import Time
import Time.Codec


type alias Meta =
    { status : Status
    , created : TimeCreated
    , modified : TimeModified

    --
    , order : ElmShop.Document.Utils.Order.Order
    , note : ElmShop.Document.Utils.Note.Note
    }


create : Task.Task x Meta
create =
    Task.succeed
        (\x ->
            { status = Published x
            , created = TimeCreated x
            , modified = TimeModified x

            --
            , order = ElmShop.Document.Utils.Order.default
            , note = ElmShop.Document.Utils.Note.fromString ""
            }
        )
        |> Task.Extra.apply Time.now



--


type Status
    = Draft Time.Posix
    | Published Time.Posix
    | Trashed Time.Posix



--


type TimeCreated
    = TimeCreated Time.Posix



--


type TimeModified
    = TimeModified Time.Posix



--


codec : Codec.Codec Meta
codec =
    Codec.object (\x1 x2 x3 x4 x5 -> { status = x1, created = x2, modified = x3, order = x4, note = x5 })
        |> Codec.field "status" .status statusCodec
        |> Codec.field "created" .created timeCreatedCodec
        |> Codec.field "modified" .modified timeModifiedCodec
        |> Codec.field "order" .order ElmShop.Document.Utils.Order.codec
        |> Codec.field "note" .note ElmShop.Document.Utils.Note.codec
        |> Codec.buildObject


timeModifiedCodec : Codec.Codec TimeModified
timeModifiedCodec =
    Codec.custom
        (\fn1 x ->
            case x of
                TimeModified x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "TimeModified" TimeModified Time.Codec.posix
        |> Codec.buildCustom


timeCreatedCodec : Codec.Codec TimeCreated
timeCreatedCodec =
    Codec.custom
        (\fn1 x ->
            case x of
                TimeCreated x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "TimeCreated" TimeCreated Time.Codec.posix
        |> Codec.buildCustom


statusCodec : Codec.Codec Status
statusCodec =
    Codec.custom
        (\fn1 fn2 fn3 x ->
            case x of
                Draft x1 ->
                    fn1 x1

                Published x1 ->
                    fn2 x1

                Trashed x1 ->
                    fn3 x1
        )
        |> Codec.variant1 "Draft" Draft Time.Codec.posix
        |> Codec.variant1 "Published" Published Time.Codec.posix
        |> Codec.variant1 "Trashed" Trashed Time.Codec.posix
        |> Codec.buildCustom


schema : Dataman.Schema.Schema Meta
schema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Utils", "Meta" ] "Meta"))
        Nothing
        [ Dataman.Schema.RecordField "status" (Dataman.Schema.toAny statusSchema)
        , Dataman.Schema.RecordField "created" (Dataman.Schema.toAny timeCreatedSchema)
        , Dataman.Schema.RecordField "modified" (Dataman.Schema.toAny timeModifiedSchema)
        , Dataman.Schema.RecordField "order" (Dataman.Schema.toAny ElmShop.Document.Utils.Order.schema)
        , Dataman.Schema.RecordField "note" (Dataman.Schema.toAny ElmShop.Document.Utils.Note.schema)
        ]


statusSchema : Dataman.Schema.Schema Status
statusSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Utils", "Meta" ] "Status")
        Nothing
        (Dataman.Schema.Variant "Draft" [ Dataman.Schema.toAny Dataman.Schema.Basics.time ])
        [ Dataman.Schema.Variant "Published" [ Dataman.Schema.toAny Dataman.Schema.Basics.time ]
        , Dataman.Schema.Variant "Trashed" [ Dataman.Schema.toAny Dataman.Schema.Basics.time ]
        ]


timeCreatedSchema : Dataman.Schema.Schema TimeCreated
timeCreatedSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Utils", "Meta" ] "TimeCreated")
        Nothing
        (Dataman.Schema.Variant "TimeCreated" [ Dataman.Schema.toAny Dataman.Schema.Basics.time ])
        []


timeModifiedSchema : Dataman.Schema.Schema TimeModified
timeModifiedSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Utils", "Meta" ] "TimeModified")
        Nothing
        (Dataman.Schema.Variant "TimeModified" [ Dataman.Schema.toAny Dataman.Schema.Basics.time ])
        []

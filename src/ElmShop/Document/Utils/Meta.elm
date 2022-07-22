module ElmShop.Document.Utils.Meta exposing (..)

import Codec
import Dataman.Type
import ElmShop.Document.Type
import ElmShop.Document.Utils.Note
import ElmShop.Document.Utils.Order
import Reference
import Task
import Task.Extra
import Time
import Time.Codec


type alias Meta =
    { status : Status
    , created : TimeCreated
    , modified : TimeModified
    , author : Maybe (Reference.Reference ElmShop.Document.Type.User)

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
            , author = Nothing

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
    Codec.record (\x1 x2 x3 x4 x5 x6 -> { status = x1, created = x2, modified = x3, author = x4, order = x5, note = x6 })
        |> Codec.field .status statusCodec
        |> Codec.field .created timeCreatedCodec
        |> Codec.field .modified timeModifiedCodec
        |> Codec.field .author (Codec.maybe Reference.codec)
        |> Codec.field .order ElmShop.Document.Utils.Order.codec
        |> Codec.field .note ElmShop.Document.Utils.Note.codec
        |> Codec.buildRecord


timeModifiedCodec : Codec.Codec TimeModified
timeModifiedCodec =
    Codec.custom
        (\fn1 x ->
            case x of
                TimeModified x1 ->
                    fn1 x1
        )
        |> Codec.variant1 TimeModified Time.Codec.posix
        |> Codec.buildCustom


timeCreatedCodec : Codec.Codec TimeCreated
timeCreatedCodec =
    Codec.custom
        (\fn1 x ->
            case x of
                TimeCreated x1 ->
                    fn1 x1
        )
        |> Codec.variant1 TimeCreated Time.Codec.posix
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
        |> Codec.variant1 Draft Time.Codec.posix
        |> Codec.variant1 Published Time.Codec.posix
        |> Codec.variant1 Trashed Time.Codec.posix
        |> Codec.buildCustom


type_ : Dataman.Type.Type Meta
type_ =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Utils", "Meta" ] "Meta")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "status", type_ = Dataman.Type.toAny statusType }
            , { name = Dataman.Type.FieldName "created", type_ = Dataman.Type.toAny timeCreatedType }
            , { name = Dataman.Type.FieldName "modified", type_ = Dataman.Type.toAny timeModifiedType }
            , { name = Dataman.Type.FieldName "author", type_ = Dataman.Type.toAny (Dataman.Type.maybe ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.userType)) }
            , { name = Dataman.Type.FieldName "order", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Order.type_ }
            , { name = Dataman.Type.FieldName "note", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Note.type_ }
            ]
        }


statusType : Dataman.Type.Type Status
statusType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Utils", "Meta" ] "Status"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Draft", arguments = [ Dataman.Type.toAny (Dataman.Type.TimePosix |> Dataman.Type.Opaque_) ] }
            , [ { name = Dataman.Type.VariantName "Published", arguments = [ Dataman.Type.toAny (Dataman.Type.TimePosix |> Dataman.Type.Opaque_) ] }
              , { name = Dataman.Type.VariantName "Trashed", arguments = [ Dataman.Type.toAny (Dataman.Type.TimePosix |> Dataman.Type.Opaque_) ] }
              ]
            )
        }


timeCreatedType : Dataman.Type.Type TimeCreated
timeCreatedType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Utils", "Meta" ] "TimeCreated"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "TimeCreated", arguments = [ Dataman.Type.toAny (Dataman.Type.TimePosix |> Dataman.Type.Opaque_) ] }
            , []
            )
        }


timeModifiedType : Dataman.Type.Type TimeModified
timeModifiedType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Utils", "Meta" ] "TimeModified"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "TimeModified", arguments = [ Dataman.Type.toAny (Dataman.Type.TimePosix |> Dataman.Type.Opaque_) ] }
            , []
            )
        }

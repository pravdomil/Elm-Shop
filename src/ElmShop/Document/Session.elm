module ElmShop.Document.Session exposing (..)

import Codec
import Dataman.Schema
import Dataman.Schema.Basics
import ElmShop.Document.Type
import ElmShop.Document.Utils.Meta
import Id
import Id.Random
import Reference
import Task
import Task.Extra


type alias Session =
    { user : Maybe (Reference.Reference ElmShop.Document.Type.User)
    , order : Maybe (Reference.Reference ElmShop.Document.Type.Order)

    --
    , meta : ElmShop.Document.Utils.Meta.Meta
    }


create : Task.Task x ( Id.Id ElmShop.Document.Type.Session, Session )
create =
    Task.succeed
        (\x x2 ->
            ( x
            , { user = Nothing
              , order = Nothing

              --
              , meta = x2
              }
            )
        )
        |> Task.Extra.apply Id.Random.generate
        |> Task.Extra.apply ElmShop.Document.Utils.Meta.create



--


codec : Codec.Codec Session
codec =
    Codec.record (\x1 x2 x3 -> { user = x1, order = x2, meta = x3 })
        |> Codec.field "user" .user (Codec.maybe Reference.codec)
        |> Codec.field "order" .order (Codec.maybe Reference.codec)
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.buildRecord


schema : Dataman.Schema.Schema Session
schema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Session" ] "Session"))
        Nothing
        [ Dataman.Schema.RecordField "user" (Dataman.Schema.toAny (Dataman.Schema.Basics.maybe (Dataman.Schema.Basics.reference ElmShop.Document.Type.userSchema)))
        , Dataman.Schema.RecordField "order" (Dataman.Schema.toAny (Dataman.Schema.Basics.maybe (Dataman.Schema.Basics.reference ElmShop.Document.Type.orderSchema)))
        , Dataman.Schema.RecordField "meta" (Dataman.Schema.toAny ElmShop.Document.Utils.Meta.schema)
        ]

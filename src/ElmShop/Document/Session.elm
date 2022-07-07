module ElmShop.Document.Session exposing (..)

import Codec
import Codec.Extra
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
    { id : Id.Id ElmShop.Document.Type.Session
    , meta : ElmShop.Document.Utils.Meta.Meta

    --
    , user : Maybe (Reference.Reference ElmShop.Document.Type.User)
    , order : Maybe (Reference.Reference ElmShop.Document.Type.Order)
    }


create : Task.Task x Session
create =
    Task.succeed
        (\x x2 ->
            { id = x
            , meta = x2

            --
            , user = Nothing
            , order = Nothing
            }
        )
        |> Task.Extra.apply Id.Random.generate
        |> Task.Extra.apply ElmShop.Document.Utils.Meta.create



--


codec : Codec.Codec Session
codec =
    Codec.object (\x1 x2 x3 x4 -> { id = x1, meta = x2, user = x3, order = x4 })
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "user" .user (Codec.Extra.maybe Reference.codec)
        |> Codec.field "order" .order (Codec.Extra.maybe Reference.codec)
        |> Codec.buildObject


schema : Dataman.Schema.Schema Session
schema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Session" ] "Session"))
        Nothing
        [ Dataman.Schema.RecordField "id" (Dataman.Schema.toAny (Dataman.Schema.Basics.id ElmShop.Document.Type.sessionSchema))
        , Dataman.Schema.RecordField "meta" (Dataman.Schema.toAny ElmShop.Document.Utils.Meta.schema)
        , Dataman.Schema.RecordField "user" (Dataman.Schema.toAny (Dataman.Schema.Basics.maybe (Dataman.Schema.Basics.reference ElmShop.Document.Type.userSchema)))
        , Dataman.Schema.RecordField "order" (Dataman.Schema.toAny (Dataman.Schema.Basics.maybe (Dataman.Schema.Basics.reference ElmShop.Document.Type.orderSchema)))
        ]

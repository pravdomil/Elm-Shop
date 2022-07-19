module ElmShop.Document.User exposing (..)

import Codec
import Dataman.Schema
import Dataman.Schema.Basics
import ElmShop.Document.Type
import ElmShop.Document.Utils.Email
import ElmShop.Document.Utils.Meta
import ElmShop.Document.Utils.Name
import ElmShop.Document.Utils.Password
import Id
import Id.Random
import Task
import Task.Extra


type alias User =
    { name : ElmShop.Document.Utils.Name.Name
    , email : Maybe ElmShop.Document.Utils.Email.Email
    , password : ElmShop.Document.Utils.Password.Password

    --
    , meta : ElmShop.Document.Utils.Meta.Meta
    }


create : Task.Task x ( Id.Id ElmShop.Document.Type.User, User )
create =
    Task.succeed
        (\x x2 x3 ->
            ( x
            , { name = ElmShop.Document.Utils.Name.fromString "Admin" |> Maybe.withDefault ElmShop.Document.Utils.Name.default
              , email = Nothing
              , password = x2

              --
              , meta = x3
              }
            )
        )
        |> Task.Extra.apply Id.Random.generate
        |> Task.Extra.apply ElmShop.Document.Utils.Password.create
        |> Task.Extra.apply ElmShop.Document.Utils.Meta.create



--


codec : Codec.Codec User
codec =
    Codec.record (\x1 x2 x3 x4 -> { name = x1, email = x2, password = x3, meta = x4 })
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "email" .email (Codec.maybe ElmShop.Document.Utils.Email.codec)
        |> Codec.field "password" .password ElmShop.Document.Utils.Password.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.buildRecord


schema : Dataman.Schema.Schema User
schema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "User" ] "User"))
        Nothing
        [ Dataman.Schema.RecordField "name" (Dataman.Schema.toAny ElmShop.Document.Utils.Name.schema)
        , Dataman.Schema.RecordField "email" (Dataman.Schema.toAny (Dataman.Schema.Basics.maybe ElmShop.Document.Utils.Email.schema))
        , Dataman.Schema.RecordField "password" (Dataman.Schema.toAny ElmShop.Document.Utils.Password.schema)
        , Dataman.Schema.RecordField "meta" (Dataman.Schema.toAny ElmShop.Document.Utils.Meta.schema)
        ]

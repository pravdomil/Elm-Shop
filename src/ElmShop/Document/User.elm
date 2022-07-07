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
    { id : Id.Id ElmShop.Document.Type.User
    , meta : ElmShop.Document.Utils.Meta.Meta

    --
    , name : ElmShop.Document.Utils.Name.Name
    , email : Maybe ElmShop.Document.Utils.Email.Email
    , password : ElmShop.Document.Utils.Password.Password
    }


create : Task.Task x User
create =
    Task.succeed
        (\x x2 x3 ->
            { id = x
            , meta = x2

            --
            , name = ElmShop.Document.Utils.Name.fromString "Admin" |> Maybe.withDefault ElmShop.Document.Utils.Name.default
            , email = Nothing
            , password = x3
            }
        )
        |> Task.Extra.apply Id.Random.generate
        |> Task.Extra.apply ElmShop.Document.Utils.Meta.create
        |> Task.Extra.apply ElmShop.Document.Utils.Password.create



--


codec : Codec.Codec User
codec =
    Codec.object (\x1 x2 x3 x4 x5 -> { id = x1, meta = x2, name = x3, email = x4, password = x5 })
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "name" .name ElmShop.Document.Utils.Name.codec
        |> Codec.field "email" .email (Codec.maybe ElmShop.Document.Utils.Email.codec)
        |> Codec.field "password" .password ElmShop.Document.Utils.Password.codec
        |> Codec.buildObject


schema : Dataman.Schema.Schema User
schema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "User" ] "User"))
        Nothing
        [ Dataman.Schema.RecordField "id" (Dataman.Schema.toAny (Dataman.Schema.Basics.id ElmShop.Document.Type.userSchema))
        , Dataman.Schema.RecordField "meta" (Dataman.Schema.toAny ElmShop.Document.Utils.Meta.schema)
        , Dataman.Schema.RecordField "name" (Dataman.Schema.toAny ElmShop.Document.Utils.Name.schema)
        , Dataman.Schema.RecordField "email" (Dataman.Schema.toAny (Dataman.Schema.Basics.maybe ElmShop.Document.Utils.Email.schema))
        , Dataman.Schema.RecordField "password" (Dataman.Schema.toAny ElmShop.Document.Utils.Password.schema)
        ]

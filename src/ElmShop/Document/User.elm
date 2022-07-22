module ElmShop.Document.User exposing (..)

import Codec
import Dataman.Type
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
        |> Codec.field .name ElmShop.Document.Utils.Name.codec
        |> Codec.field .email (Codec.maybe ElmShop.Document.Utils.Email.codec)
        |> Codec.field .password ElmShop.Document.Utils.Password.codec
        |> Codec.field .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.buildRecord


type_ : Dataman.Type.Type User
type_ =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "User" ] "User")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "name", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Name.type_ }
            , { name = Dataman.Type.FieldName "email", type_ = Dataman.Type.toAny (Dataman.Type.maybe ElmShop.Document.Utils.Email.type_) }
            , { name = Dataman.Type.FieldName "password", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Password.type_ }
            , { name = Dataman.Type.FieldName "meta", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Meta.type_ }
            ]
        }

module ElmShop.Document.Session exposing (..)

import Codec
import Dataman.Type
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


type_ : Dataman.Type.Type Session
type_ =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Session" ] "Session")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "user", type_ = Dataman.Type.toAny (Dataman.Type.maybe ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.userType)) }
            , { name = Dataman.Type.FieldName "order", type_ = Dataman.Type.toAny (Dataman.Type.maybe ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) ElmShop.Document.Type.orderType)) }
            , { name = Dataman.Type.FieldName "meta", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Meta.type_ }
            ]
        }

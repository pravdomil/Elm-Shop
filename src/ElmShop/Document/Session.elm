module ElmShop.Document.Session exposing (..)

import Codec
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


codec : Codec.Codec Session
codec =
    Codec.object Session
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "user" .user (Codec.maybe Reference.codec)
        |> Codec.field "order" .order (Codec.maybe Reference.codec)
        |> Codec.buildObject

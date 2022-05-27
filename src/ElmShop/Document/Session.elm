module ElmShop.Document.Session exposing (..)

import Codec
import ElmShop.Document.Type
import ElmShop.Document.Utils.Meta
import Id
import Reference


type alias Session =
    { id : Id.Id ElmShop.Document.Type.Session
    , meta : ElmShop.Document.Utils.Meta.Meta

    --
    , user : Maybe (Reference.Reference ElmShop.Document.Type.User)
    , order : Maybe (Reference.Reference ElmShop.Document.Type.Order)
    }


codec : Codec.Codec Session
codec =
    Codec.object Session
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "user" .user (Codec.maybe Reference.codec)
        |> Codec.field "order" .order (Codec.maybe Reference.codec)
        |> Codec.buildObject

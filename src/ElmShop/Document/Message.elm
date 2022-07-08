module ElmShop.Document.Message exposing (..)

import Codec
import Dataman.Schema
import Dataman.Schema.Basics
import ElmShop.Document.Type
import ElmShop.Document.Utils.Meta
import Id
import Reference


type alias Message =
    { id : Id.Id ElmShop.Document.Type.Message
    , meta : ElmShop.Document.Utils.Meta.Meta

    --
    , type_ : Type
    , message : Content
    , related : List (Reference.Reference ())
    }



--


type Content
    = Content String



--


type Type
    = Info
    | Warning
    | Error



--


codec : Codec.Codec Message
codec =
    Codec.object (\x1 x2 x3 x4 x5 -> { id = x1, meta = x2, type_ = x3, message = x4, related = x5 })
        |> Codec.field "id" .id Id.codec
        |> Codec.field "meta" .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.field "type_" .type_ typeCodec
        |> Codec.field "message" .message contentCodec
        |> Codec.field "related" .related (Codec.list Reference.codec)
        |> Codec.buildObject


contentCodec : Codec.Codec Content
contentCodec =
    Codec.custom
        (\fn1 x ->
            case x of
                Content x1 ->
                    fn1 x1
        )
        |> Codec.variant1 "Content" Content Codec.string
        |> Codec.buildCustom


typeCodec : Codec.Codec Type
typeCodec =
    Codec.custom
        (\fn1 fn2 fn3 x ->
            case x of
                Info ->
                    fn1

                Warning ->
                    fn2

                Error ->
                    fn3
        )
        |> Codec.variant0 "Info" Info
        |> Codec.variant0 "Warning" Warning
        |> Codec.variant0 "Error" Error
        |> Codec.buildCustom


schema : Dataman.Schema.Schema Message
schema =
    Dataman.Schema.Record (Just (Dataman.Schema.Name [ "ElmShop", "Document", "Message" ] "Message"))
        Nothing
        [ Dataman.Schema.RecordField "id" (Dataman.Schema.toAny (Dataman.Schema.Basics.id ElmShop.Document.Type.messageSchema))
        , Dataman.Schema.RecordField "meta" (Dataman.Schema.toAny ElmShop.Document.Utils.Meta.schema)
        , Dataman.Schema.RecordField "type_" (Dataman.Schema.toAny typeSchema)
        , Dataman.Schema.RecordField "message" (Dataman.Schema.toAny contentSchema)
        , Dataman.Schema.RecordField "related" (Dataman.Schema.toAny (Dataman.Schema.Basics.list (Dataman.Schema.Basics.reference (Dataman.Schema.Tuple Nothing Nothing []))))
        ]


typeSchema : Dataman.Schema.Schema Type
typeSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Message" ] "Type")
        Nothing
        (Dataman.Schema.Variant "Info" [])
        [ Dataman.Schema.Variant "Warning" []
        , Dataman.Schema.Variant "Error" []
        ]


contentSchema : Dataman.Schema.Schema Content
contentSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Message" ] "Content")
        Nothing
        (Dataman.Schema.Variant "Content" [ Dataman.Schema.toAny Dataman.Schema.Basics.string ])
        []

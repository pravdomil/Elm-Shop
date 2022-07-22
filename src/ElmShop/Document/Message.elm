module ElmShop.Document.Message exposing (..)

import Codec
import Dataman.Type
import ElmShop.Document.Utils.Meta
import Reference


type alias Message =
    { type_ : Type
    , message : Content
    , related : List (Reference.Reference ())

    --
    , meta : ElmShop.Document.Utils.Meta.Meta
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
    Codec.record (\x1 x2 x3 x4 -> { type_ = x1, message = x2, related = x3, meta = x4 })
        |> Codec.field .type_ typeCodec
        |> Codec.field .message contentCodec
        |> Codec.field .related (Codec.list Reference.codec)
        |> Codec.field .meta ElmShop.Document.Utils.Meta.codec
        |> Codec.buildRecord


contentCodec : Codec.Codec Content
contentCodec =
    Codec.lazy
        (\() ->
            Codec.custom
                (\fn1 x ->
                    case x of
                        Content x1 ->
                            fn1 x1
                )
                |> Codec.variant1 Content Codec.string
                |> Codec.buildCustom
        )


typeCodec : Codec.Codec Type
typeCodec =
    Codec.lazy
        (\() ->
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
                |> Codec.variant0 Info
                |> Codec.variant0 Warning
                |> Codec.variant0 Error
                |> Codec.buildCustom
        )


type_ : Dataman.Type.Type Message
type_ =
    Dataman.Type.Record_
        { name = Just (Dataman.Type.Name [ "ElmShop", "Document", "Message" ] "Message")
        , documentation = Nothing
        , fields =
            [ { name = Dataman.Type.FieldName "type_", type_ = Dataman.Type.toAny typeType }
            , { name = Dataman.Type.FieldName "message", type_ = Dataman.Type.toAny contentType }
            , { name = Dataman.Type.FieldName "related", type_ = Dataman.Type.toAny ((Dataman.Type.toAny >> Dataman.Type.List_ >> Dataman.Type.Opaque_) ((Dataman.Type.toAny >> Dataman.Type.Reference >> Dataman.Type.Opaque_) (Dataman.Type.Tuple_ { name = Nothing, documentation = Nothing, arguments = [] }))) }
            , { name = Dataman.Type.FieldName "meta", type_ = Dataman.Type.toAny ElmShop.Document.Utils.Meta.type_ }
            ]
        }


typeType : Dataman.Type.Type Type
typeType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Message" ] "Type"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Info", arguments = [] }
            , [ { name = Dataman.Type.VariantName "Warning", arguments = [] }
              , { name = Dataman.Type.VariantName "Error", arguments = [] }
              ]
            )
        }


contentType : Dataman.Type.Type Content
contentType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Message" ] "Content"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Content", arguments = [ Dataman.Type.toAny (Dataman.Type.String_ |> Dataman.Type.Opaque_) ] }
            , []
            )
        }

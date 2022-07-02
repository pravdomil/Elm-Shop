module ElmShop.Database.Index exposing (..)

import ElmShop.Document
import ElmShop.Document.Site
import ElmShop.Document.Type


type Index
    = ByType ElmShop.Document.Type.Type
    | BySiteUrl ElmShop.Document.Site.Url


documentToIndexes : ElmShop.Document.Document -> List Index
documentToIndexes a =
    []
        |> (\x ->
                ByType (ElmShop.Document.toType a) :: x
           )
        |> (\x ->
                case a of
                    ElmShop.Document.Site b ->
                        BySiteUrl b.url :: x

                    _ ->
                        x
           )


toComparable : Index -> List String
toComparable a =
    case a of
        ByType b ->
            (0 |> Char.fromCode |> String.fromChar)
                :: (case b of
                        ElmShop.Document.Type.Attribute_ ->
                            [ 0 |> Char.fromCode |> String.fromChar
                            ]

                        ElmShop.Document.Type.Category_ ->
                            [ 1 |> Char.fromCode |> String.fromChar
                            ]

                        ElmShop.Document.Type.Country_ ->
                            [ 2 |> Char.fromCode |> String.fromChar
                            ]

                        ElmShop.Document.Type.Currency_ ->
                            [ 3 |> Char.fromCode |> String.fromChar
                            ]

                        ElmShop.Document.Type.File_ ->
                            [ 4 |> Char.fromCode |> String.fromChar
                            ]

                        ElmShop.Document.Type.Language_ ->
                            [ 5 |> Char.fromCode |> String.fromChar
                            ]

                        ElmShop.Document.Type.Message_ ->
                            [ 6 |> Char.fromCode |> String.fromChar
                            ]

                        ElmShop.Document.Type.Order_ ->
                            [ 7 |> Char.fromCode |> String.fromChar
                            ]

                        ElmShop.Document.Type.OrderStatus_ ->
                            [ 8 |> Char.fromCode |> String.fromChar
                            ]

                        ElmShop.Document.Type.Page_ ->
                            [ 9 |> Char.fromCode |> String.fromChar
                            ]

                        ElmShop.Document.Type.Payment_ ->
                            [ 10 |> Char.fromCode |> String.fromChar
                            ]

                        ElmShop.Document.Type.Product_ ->
                            [ 11 |> Char.fromCode |> String.fromChar
                            ]

                        ElmShop.Document.Type.Review_ ->
                            [ 12 |> Char.fromCode |> String.fromChar
                            ]

                        ElmShop.Document.Type.Session_ ->
                            [ 13 |> Char.fromCode |> String.fromChar
                            ]

                        ElmShop.Document.Type.Shipping_ ->
                            [ 14 |> Char.fromCode |> String.fromChar
                            ]

                        ElmShop.Document.Type.Site_ ->
                            [ 15 |> Char.fromCode |> String.fromChar
                            ]

                        ElmShop.Document.Type.Template_ ->
                            [ 16 |> Char.fromCode |> String.fromChar
                            ]

                        ElmShop.Document.Type.User_ ->
                            [ 17 |> Char.fromCode |> String.fromChar
                            ]

                        ElmShop.Document.Type.Warehouse_ ->
                            [ 18 |> Char.fromCode |> String.fromChar
                            ]
                   )

        BySiteUrl b ->
            [ 1 |> Char.fromCode |> String.fromChar
            , (\(ElmShop.Document.Site.Url x) -> x) b
            ]

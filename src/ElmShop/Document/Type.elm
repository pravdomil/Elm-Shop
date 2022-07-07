module ElmShop.Document.Type exposing (..)

import Dataman.Schema


type Type
    = Attribute_
    | Category_
    | Country_
    | Currency_
    | File_
    | Language_
    | Message_
    | Order_
    | OrderStatus_
    | Page_
    | Payment_
    | Product_
    | Review_
    | Session_
    | Shipping_
    | Site_
    | Template_
    | User_
    | Warehouse_



--


type Attribute
    = Attribute


type Category
    = Category


type Currency
    = Currency


type File
    = File


type Language
    = Language


type Message
    = Message


type Order
    = Order


type OrderStatus
    = OrderStatus


type Page
    = Page


type Payment
    = Payment


type Product
    = Product


type Review
    = Review


type Session
    = Session


type Shipping
    = Shipping


type Site
    = Site


type Country
    = Country


type Template
    = Template


type User
    = User


type Warehouse
    = Warehouse



--


attributeSchema : Dataman.Schema.Schema Attribute
attributeSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Type" ] "Attribute")
        Nothing
        [ Dataman.Schema.Variant "Attribute" []
        ]


categorySchema : Dataman.Schema.Schema Category
categorySchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Type" ] "Category")
        Nothing
        [ Dataman.Schema.Variant "Category" []
        ]


countrySchema : Dataman.Schema.Schema Country
countrySchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Type" ] "Country")
        Nothing
        [ Dataman.Schema.Variant "Country" []
        ]


currencySchema : Dataman.Schema.Schema Currency
currencySchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Type" ] "Currency")
        Nothing
        [ Dataman.Schema.Variant "Currency" []
        ]


fileSchema : Dataman.Schema.Schema File
fileSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Type" ] "File")
        Nothing
        [ Dataman.Schema.Variant "File" []
        ]


languageSchema : Dataman.Schema.Schema Language
languageSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Type" ] "Language")
        Nothing
        [ Dataman.Schema.Variant "Language" []
        ]


messageSchema : Dataman.Schema.Schema Message
messageSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Type" ] "Message")
        Nothing
        [ Dataman.Schema.Variant "Message" []
        ]


orderSchema : Dataman.Schema.Schema Order
orderSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Type" ] "Order")
        Nothing
        [ Dataman.Schema.Variant "Order" []
        ]


orderStatusSchema : Dataman.Schema.Schema OrderStatus
orderStatusSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Type" ] "OrderStatus")
        Nothing
        [ Dataman.Schema.Variant "OrderStatus" []
        ]


pageSchema : Dataman.Schema.Schema Page
pageSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Type" ] "Page")
        Nothing
        [ Dataman.Schema.Variant "Page" []
        ]


paymentSchema : Dataman.Schema.Schema Payment
paymentSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Type" ] "Payment")
        Nothing
        [ Dataman.Schema.Variant "Payment" []
        ]


productSchema : Dataman.Schema.Schema Product
productSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Type" ] "Product")
        Nothing
        [ Dataman.Schema.Variant "Product" []
        ]


reviewSchema : Dataman.Schema.Schema Review
reviewSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Type" ] "Review")
        Nothing
        [ Dataman.Schema.Variant "Review" []
        ]


sessionSchema : Dataman.Schema.Schema Session
sessionSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Type" ] "Session")
        Nothing
        [ Dataman.Schema.Variant "Session" []
        ]


shippingSchema : Dataman.Schema.Schema Shipping
shippingSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Type" ] "Shipping")
        Nothing
        [ Dataman.Schema.Variant "Shipping" []
        ]


siteSchema : Dataman.Schema.Schema Site
siteSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Type" ] "Site")
        Nothing
        [ Dataman.Schema.Variant "Site" []
        ]


templateSchema : Dataman.Schema.Schema Template
templateSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Type" ] "Template")
        Nothing
        [ Dataman.Schema.Variant "Template" []
        ]


userSchema : Dataman.Schema.Schema User
userSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Type" ] "User")
        Nothing
        [ Dataman.Schema.Variant "User" []
        ]


warehouseSchema : Dataman.Schema.Schema Warehouse
warehouseSchema =
    Dataman.Schema.CustomType (Dataman.Schema.Name [ "ElmShop", "Document", "Type" ] "Warehouse")
        Nothing
        [ Dataman.Schema.Variant "Warehouse" []
        ]

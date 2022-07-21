module ElmShop.Document.Type exposing (..)

import Dataman.Type


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


attributeType : Dataman.Type.Type Attribute
attributeType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Type" ] "Attribute"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Attribute", arguments = [] }
            , []
            )
        }


categoryType : Dataman.Type.Type Category
categoryType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Type" ] "Category"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Category", arguments = [] }
            , []
            )
        }


countryType : Dataman.Type.Type Country
countryType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Type" ] "Country"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Country", arguments = [] }
            , []
            )
        }


currencyType : Dataman.Type.Type Currency
currencyType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Type" ] "Currency"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Currency", arguments = [] }
            , []
            )
        }


fileType : Dataman.Type.Type File
fileType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Type" ] "File"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "File", arguments = [] }
            , []
            )
        }


languageType : Dataman.Type.Type Language
languageType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Type" ] "Language"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Language", arguments = [] }
            , []
            )
        }


messageType : Dataman.Type.Type Message
messageType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Type" ] "Message"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Message", arguments = [] }
            , []
            )
        }


orderType : Dataman.Type.Type Order
orderType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Type" ] "Order"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Order", arguments = [] }
            , []
            )
        }


orderStatusType : Dataman.Type.Type OrderStatus
orderStatusType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Type" ] "OrderStatus"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "OrderStatus", arguments = [] }
            , []
            )
        }


pageType : Dataman.Type.Type Page
pageType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Type" ] "Page"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Page", arguments = [] }
            , []
            )
        }


paymentType : Dataman.Type.Type Payment
paymentType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Type" ] "Payment"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Payment", arguments = [] }
            , []
            )
        }


productType : Dataman.Type.Type Product
productType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Type" ] "Product"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Product", arguments = [] }
            , []
            )
        }


reviewType : Dataman.Type.Type Review
reviewType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Type" ] "Review"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Review", arguments = [] }
            , []
            )
        }


sessionType : Dataman.Type.Type Session
sessionType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Type" ] "Session"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Session", arguments = [] }
            , []
            )
        }


shippingType : Dataman.Type.Type Shipping
shippingType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Type" ] "Shipping"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Shipping", arguments = [] }
            , []
            )
        }


siteType : Dataman.Type.Type Site
siteType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Type" ] "Site"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Site", arguments = [] }
            , []
            )
        }


templateType : Dataman.Type.Type Template
templateType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Type" ] "Template"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Template", arguments = [] }
            , []
            )
        }


userType : Dataman.Type.Type User
userType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Type" ] "User"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "User", arguments = [] }
            , []
            )
        }


warehouseType : Dataman.Type.Type Warehouse
warehouseType =
    Dataman.Type.Custom_
        { name = Dataman.Type.Name [ "ElmShop", "Document", "Type" ] "Warehouse"
        , documentation = Nothing
        , variants =
            ( { name = Dataman.Type.VariantName "Warehouse", arguments = [] }
            , []
            )
        }

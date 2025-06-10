namespace com.logali;

using {
    cuid,
    managed
} from '@sap/cds/common';

type Name                   : String(50);
type Dec                    : Decimal(16, 2);

//Tipo estructurado
type Address {

    Street     : String;
    City       : String;
    State      : String(2);
    PostalCode : String(5);
    Country    : String(3);

};


context materials {

    entity Products : cuid { //managed
        Name             : localized Name not null;
        Description      : localized String;
        ImageUrl         : String;
        ReleaseDate      : DateTime default $now;
        DiscontinuedDate : DateTime default $now;
        Price            : Dec;
        Height           : type of Price;
        Width            : Decimal(16, 2);
        Depth            : Decimal(16, 2);
        Quantity         : Decimal(16, 2);
        UnitOfMeasure    : Association to UnitOfMeasures;
        Currency         : Association to Currencies;
        Category         : Association to Categories;
        Supplier         : Association to sales.Suppliers;
        DimensionUnit    : Association to DimensionUnits;
        SalesData        : Association to many sales.SalesData
                               on SalesData.Product = $self;
        Reviews          : Association to many ProductReview
                               on Reviews.Product = $self;
    };

    entity Categories {
        key ID   : String(1);
            Name : localized Name
    };

    entity StockAvailability {
        key ID          : Integer;
            Description : localized String;
    };

    entity Currencies {
        key ID          : String(3);
            Description : localized String;
    };

    entity UnitOfMeasures {
        key ID          : String(2);
            Description : localized String;
    };

    entity DimensionUnits {
        key ID          : String(2);
            Description : localized String;
    };

    entity ProductReview : cuid, managed {
        Name    : Name;
        Rating  : Integer;
        Comment : String;
        Product : Association to Products;
    };

    entity SelProducts   as select from Products;
    entity ProjProducts  as projection on Products;

    entity ProjProducts2 as
        projection on Products {
            *
        };

    entity ProjProducts3 as
        projection on Products {
            ReleaseDate,
            Name
        };

    extend Products with {
        PriceCondition     : String(2);
        PriceDetermination : String(3);
    };

    type EmailsAddresses_01 : array of {
        kind  : String;
        email : String;
    };

    type EmailsAddresses_02 : array of {
        kind  : String;
        email : String;
    };

    type Emails             : {
        email_01  : many EmailsAddresses_01;
        email_02  : many EmailsAddresses_02;
        email_03  : many {
            kind  :      String;
            email :      String;
        };
    };

}

context sales {

    entity Orders : cuid {
        Date     : Date;
        Customer : String;
        Item     : Composition of many OrderItems
                       on Item.Order = $self;
    };

    entity OrderItems : cuid {
        Order    : Association to Orders;
        Product  : Association to materials.Products;
        Quantity : Integer;
    };

    entity Suppliers : cuid, managed {
        Name    : Name;
        Address : Address;
        Email   : String;
        Phone   : String;
        Fax     : String;
        Product : Association to many materials.Products
                      on Product.Supplier = $self;
    };

    entity Months {
        key ID               : String(2);
            Description      : String;
            ShortDescription : String(3);
    };

    entity SelProducts1 as
        select from materials.Products {
            *
        };

    entity SelProducts2 as
        select from materials.Products {
            Name,
            Price,
            Quantity
        };

    entity SelProducts3 as
        select from materials.Products
        left join materials.ProductReview
            on Products.Name = ProductReview.Name
        {
            ProductReview.Rating,
            Products.Name,
            sum(
                Products.Price
            ) as totalPrice
        }
        group by
            ProductReview.Rating,
            Products.Name
        order by
            ProductReview.Rating;

    entity SalesData : cuid, managed {
        DeliveryDate  : DateTime;
        Revenue       : Decimal(16, 2);
        Product       : Association to materials.Products;
        Currency      : Association to materials.Currencies;
        DeliveryMonth : Association to Months;
    }
}


context reports {

    entity AverageRating as
        select from logali.materials.ProductReview {
            Product.ID  as ProductId,
            avg(Rating) as AverageRating : Decimal(16, 2)

        }
        group by
            Product.ID;

    entity Products      as
        select from logali.materials.Products
        mixin {
            ToStockAvailability : Association to logali.materials.StockAvailability
                                      on ToStockAvailability.ID = $projection.StockAvailability;
            ToAverageRating     : Association to AverageRating
                                      on ToAverageRating.ProductId = ID;
        }
        into {
            *,
            ToAverageRating.AverageRating as Rating,
            case
                when
                    Quantity >= 8
                then
                    3
                when
                    Quantity > 0
                then
                    2
                else
                    1
            end                           as StockAvailability : Integer,
            ToStockAvailability
        }


}


//Enumeraciones
type Gender                 : String enum {
    male;
    female;
};


entity Order {
    clientGender : Gender;
    status       : Integer enum {
        submitted = 1;
        fulfiller = 2;
        shipped   = 3;
        cancel    = -1;
    };

    Priority     : String enum {
        high;
        medium;
        low;
    }
};


entity Car {
    key ID         : UUID;
        name       : String;
        discount_1 : Decimal;
        discount_2 : Decimal;
};


//entity ParamProducts(pName : String)     as
//    select from Products {
//        Name,
//        Price,
//        Quantity
//    }
//    where
//        Name = :pName;

//entity ProjParamProducts(pName : String) as projection on Products
//                                            where
//                                                Name = :pName;


entity Course {
    key ID      : UUID;
        Student : Association to many StudentCourse
                      on Student.Course = $self;
};


entity Student {
    key ID     : UUID;
        Course : Association to many StudentCourse
                     on Course.Student = $self;
};


entity StudentCourse {
    key ID      : UUID;
        Student : Association to Student;
        Course  : Association to Course;
};

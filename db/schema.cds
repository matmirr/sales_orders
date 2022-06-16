namespace com.matmir;

using {
    cuid,
    sap.common.CodeList as CodeList
} from '@sap/cds/common';


/**
 * TYPES
 */
type zde_meins : String(3) enum {

    PC; // Piece
    PK // Pack

}

type status : Integer enum {

    Submitted = 1;
    Fulfilled = 2;
    Shipped   = 3;
    Canceled  = -1

};

/**
 * ENTITIES
 */

entity SalesOrders : cuid {
    @mandatory
    Email              : String(30);
    FirstName          : String(30);
    LastName           : String;
    Country            : Association to one Countries;
    CreatedOn          : Date;
    DeliveryDate       : DateTime;
    OrderStatus        : Association to one OrderStatus;
    Items              : Composition of many SalesOrderItems
                             on Items.SalesOrder = $self;
    virtual TotalPrice : Decimal(12, 2)
}

entity SalesOrderItems : cuid {
    SalesOrder       : Association to one SalesOrders;
    Name             : String(40);
    Description      : String(40);
    ReleaseDate      : Date;
    DiscontinuedDate : Date;
    Price            : Decimal(12, 2);
    Height           : Decimal(15, 3);
    Width            : Decimal(13, 3);
    Depth            : Decimal(12, 2);
    Quantity         : Decimal(16, 3);
    UnitOfMeasure    : zde_meins;
    ImageUrl         : String;
}

entity Countries {
    key ID          : String(2);
        Description : localized String(30);
}

entity OrderStatus {
    key ID          : status;
        Description : localized String(30);
}

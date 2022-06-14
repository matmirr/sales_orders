namespace com.matmir;

using {
    cuid,
    Country
} from '@sap/cds/common';

/**
 * TYPES
 */
type zde_meins : String(3) enum {

    PC; // Piece
    PK // Pack

}

type OrderStatus : Integer enum {

    submitted = 1;
    fulfiller = 2;
    shipped   = 3;
    cancel    = -1

};

/**
 * ENTITIES
 */

entity SalesOrders : cuid {


    Email        : String(30) @mandatory;
    FirstName    : String(30);
    LastName     : String;
    Country      : Country    @assert.integrity : false;
    CreatedOn    : Date;
    DeliveryDate : DateTime;
    OrderStatus  : OrderStatus;
    Items        : Composition of many SalesOrderItems
                       on Items.SalesOrder = $self

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

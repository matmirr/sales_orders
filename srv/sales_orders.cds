using com.matmir as matmir from '../db/schema';

define service ManageOrders {

    @odata.draft.enabled
    entity SalesOrders     as projection on matmir.SalesOrders;

    entity SalesOrderItems as select from matmir.SalesOrderItems {
            *,
            Price * Quantity as TotalLine : Decimal(12, 2) 
    };


    @readonly
    entity VH_Countries    as
        select from matmir.Countries {
            ID          as Code,
            Description as Text
        };

    @readonly
    entity VH_OrderStatus  as
        select from matmir.OrderStatus {
            ID          as Code,
            Description as Text
        }
}

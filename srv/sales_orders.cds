using com.matmir as matmir from '../db/schema';

service ManageOrders {

    entity SalesOrders     as projection on matmir.SalesOrders;
    entity SalesOrderItems as projection on matmir.SalesOrderItems;
}
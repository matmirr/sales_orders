using ManageOrders as service from '../../srv/sales_orders';

/**
 * Annotations for SalesOrder Entity
 */
annotate service.SalesOrders with @(

    UI.HeaderInfo      : {
        TypeName       : 'Sales Order',
        TypeNamePlural : 'Sales Orders',
        Title          : {
            Label : 'Status',
            Value : OrderStatus.Text
        },
        Description    : {
            Label : 'Total Price',
            Value : TotalPrice
        }
    },

    UI.SelectionFields : [

        Email,
        Country_ID,
        OrderStatus_ID

    ],

    UI.LineItem        : [
        {
            $Type : 'UI.DataField',
            Label : 'Email',
            Value : Email,
        },
        {
            $Type : 'UI.DataField',
            Label : 'FirstName',
            Value : FirstName,
        },
        {
            $Type : 'UI.DataField',
            Label : 'LastName',
            Value : LastName,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Country',
            Value : Country_ID,
        },
        {
            $Type : 'UI.DataField',
            Label : 'DeliveryDate',
            Value : DeliveryDate,
        },
        {
            $Type : 'UI.DataField',
            Label : 'OrderStatus',
            Value : OrderStatus_ID,
        }
    ]
);

annotate service.SalesOrders with @(
    UI.FieldGroup #OrderDetails : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            {
                $Type : 'UI.DataField',
                Label : 'FirstName',
                Value : FirstName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'LastName',
                Value : LastName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Email',
                Value : Email,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Country',
                Value : Country_ID
            },
            {
                $Type : 'UI.DataField',
                Label : 'DeliveryDate',
                Value : DeliveryDate,
            },
        ],
    },
    UI.Facets                   : [
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'OrderDetails',
            Label  : 'General Information',
            Target : '@UI.FieldGroup#OrderDetails',
        },
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'Items',
            Label  : 'Details',
            Target : 'Items/@UI.LineItem',
        }
    ]
);

/**
 * Annotations for SalesOrderItems Entity
 */

annotate service.SalesOrderItems with @UI : {

    HeaderInfo              : {
        TypeName       : 'Item',
        TypeNamePlural : 'Items'
    },

    PresentationVariant     : {
        SortOrder      : [ //Default sort order
        {
            Property   : Price,
            Descending : true,
        }, ],
        Visualizations : ['@UI.LineItem'],
    },

    LineItem                : [
        {
            $Type : 'UI.DataField',
            Label : 'ImageUrl',
            Value : ImageUrl,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Name',
            Value : Name,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Description',
            Value : Description,
        },
        {
            $Type : 'UI.DataField',
            Label : 'ReleaseDate',
            Value : ReleaseDate,
        },
        {
            $Type : 'UI.DataField',
            Label : 'DiscontinuedDate',
            Value : DiscontinuedDate,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Price',
            Value : Price,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Height',
            Value : Height,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Width',
            Value : Width,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Depth',
            Value : Depth,
        },
        {
            $Type : 'UI.DataField',
            Label : 'UnitOfMeasure',
            Value : UnitOfMeasure,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Quantity',
            Value : Quantity,
        },
        {
            $Type : 'UI.DataField',
            Label : 'TotalLine',
            Value : TotalLine,
        },
    ],

    FieldGroup #ItemDetails : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            {
                $Type : 'UI.DataField',
                Label : 'ImageUrl',
                Value : ImageUrl,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Name',
                Value : Name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Description',
                Value : Description,
            },
            {
                $Type : 'UI.DataField',
                Label : 'ReleaseDate',
                Value : ReleaseDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'DiscontinuedDate',
                Value : DiscontinuedDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Price',
                Value : Price,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Height',
                Value : Height,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Width',
                Value : Width,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Depth',
                Value : Depth,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Quantity',
                Value : Quantity,
            },
            {
                $Type : 'UI.DataField',
                Label : 'UnitOfMeasure',
                Value : UnitOfMeasure,
            },
        ]
    },

    Facets                  : [{
        $Type  : 'UI.ReferenceFacet',
        ID     : 'ItemDetails',
        Label  : 'General Information',
        Target : '@UI.FieldGroup#ItemDetails',
    }]

};

annotate service.SalesOrderItems {
    ImageUrl @(UI.IsImageURL : true)
};

/**
 * Search Helps
 */
annotate service.SalesOrders with {

    // Country
    Country     @(Common : {
        Text      : {
            $value                 : Country_ID,
            ![@UI.TextArrangement] : #TextOnly,
        },
        ValueList : {
            CollectionPath : 'VH_Countries',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : Country_ID,
                    ValueListProperty : 'Code'
                },
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : Country_ID,
                    ValueListProperty : 'Text'
                }
            ]
        }
    });

    //Order Status
    OrderStatus @(Common : {

    ValueList : {
        CollectionPath : 'VH_OrderStatus',
        Parameters     : [
            {
                $Type             : 'Common.ValueListParameterInOut',
                LocalDataProperty : OrderStatus_ID,
                ValueListProperty : 'Code'
            },
            {
                $Type             : 'Common.ValueListParameterInOut',
                LocalDataProperty : OrderStatus_ID,
                ValueListProperty : 'Text'
            }
        ]
    }});

};

/**
 * Annotations for VH_Countries Entity
 */
annotate service.VH_Countries with {
    Code @(Common : {Text : {
        $value                 : Text,
        ![@UI.TextArrangement] : #TextOnly,
    }});
    Text @(UI : {HiddenFilter : true})
}

/**
 * Annotations for VH_OrderStatus Entity
 */
annotate service.VH_OrderStatus with {
    Code @(Common : {Text : {
        $value                 : Text,
        ![@UI.TextArrangement] : #TextOnly,
    }});
    Text @(UI : {HiddenFilter : true})
}

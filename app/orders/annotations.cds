using ManageOrders as service from '../../srv/sales_orders';

/**
 * Annotations for SalesOrder Entity
 */
annotate service.SalesOrders with @(

    UI.HeaderInfo      : {
        TypeName       : '{i18n>OrderHeader}',
        TypeNamePlural : '{i18n>OrderHeaders}',
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
            Label : '{i18n>Email}',
            Value : Email,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>FirstName}',
            Value : FirstName,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>LastName}',
            Value : LastName,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Country_ID}',
            Value : Country_ID,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>DeliveryDate}',
            Value : DeliveryDate,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>OrderStatus}',
            Value : OrderStatus_ID,
        }
    ]
);

// Navigation
annotate service.SalesOrders with @(
    UI.FieldGroup #OrderDetails : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            {
                $Type : 'UI.DataField',
                Label : '{i18n>FirstName}',
                Value : FirstName,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>LastName}',
                Value : LastName,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Email}',
                Value : Email,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Country_ID}',
                Value : Country_ID
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>DeliveryDate}',
                Value : DeliveryDate,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>OrderStatus}',
                Value : OrderStatus_ID,
            }
        ],
    },
    UI.Facets                   : [
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'OrderDetails',
            Label  : '{i18n>OrderDetails}',
            Target : '@UI.FieldGroup#OrderDetails',
        },
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'Items',
            Label  : '{i18n>Details}',
            Target : 'Items/@UI.LineItem',
        }
    ]
);

/**
 * Annotations for SalesOrderItems Entity
 */
annotate service.SalesOrderItems with @UI : {

    HeaderInfo              : {
        TypeName       : '{i18n>Item}',
        TypeNamePlural : '{i18n>Items}'
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
            Label : '{i18n>ImageUrl}',
            Value : ImageUrl,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>ItemName}',
            Value : Name,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>ItemDescription}',
            Value : Description,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>ReleaseDate}',
            Value : ReleaseDate,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>DiscontinuedDate}',
            Value : DiscontinuedDate,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Price}',
            Value : Price,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Height}',
            Value : Height,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Width}',
            Value : Width,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Depth}',
            Value : Depth,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>UnitOfMeasure}',
            Value : UnitOfMeasure,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Quantity}',
            Value : Quantity,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>TotalLine}',
            Value : TotalLine,
        },
    ],

    FieldGroup #ItemDetails : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            {
                $Type : 'UI.DataField',
                Label : '{i18n>ItemName}',
                Value : Name,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>ItemDescription}',
                Value : Description,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>ReleaseDate}',
                Value : ReleaseDate,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>DiscontinuedDate}',
                Value : DiscontinuedDate,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Price}',
                Value : Price,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Height}',
                Value : Height,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Width}',
                Value : Width,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Depth}',
                Value : Depth,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Quantity}',
                Value : Quantity,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>UnitOfMeasure}',
                Value : UnitOfMeasure,
            },
        ]
    },

    FieldGroup #ItemHeader  : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            {
                $Type : 'UI.DataField',
                Label : '{i18n>ItemName}',
                Value : Name,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>TotalLine}',
                Value : TotalLine,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>ImageUrl}',
                Value : ImageUrl,
            },
        ]
    },

    HeaderFacets            : [{
        $Type  : 'UI.ReferenceFacet',
        Target : '@UI.FieldGroup#ItemHeader',
        Label  : 'ItemHeader',
    }, ],

    Facets                  : [{
        $Type  : 'UI.ReferenceFacet',
        ID     : 'ItemDetails',
        Label  : '{i18n>ItemDetails}',
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

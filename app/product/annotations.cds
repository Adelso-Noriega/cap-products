using CatalogService as service from '../../srv/catalog-service';



annotate service.Products with @(

    Capabilities                 : {DeleteRestrictions: {
        $Type    : 'Capabilities.DeleteRestrictionsType',
        Deletable: false
    }, },

    UI.HeaderInfo                : {
        TypeName      : '{i18n>Product}',
        TypeNamePlural: '{i18n>Products}',
        ImageUrl      : ImageUrl,
        Title         : {Value: ProductName},
        Description   : {Value: Description}
    },

    UI.SelectionFields           : [
        CategoryId,
        CurrencyId,
        StockAvailability
    ],

    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: '{i18n>ReleaseDate}',
                Value: ReleaseDate,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>DiscontinuedDate}',
                Value: DiscontinuedDate,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Price}',
                Value: Price,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Height}',
                Value: Height,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Width}',
                Value: Width,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Depth}',
                Value: Depth,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Quantity}',
                Value: Quantity,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>CategoryId}',
                Value: Category,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>DimensionUnit}',
                Value: ToDimensionUnit_ID,
            },
            // {
            //     //$Type: 'UI.DataField',
            //     Label : 'Rating',
            //     //Value: Rating,
            //     $Type : 'UI.DataFieldForAnnotation',
            //     Target: '@UI.DataPoint#AverageRating'
            // },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>StockAvailability}',
                Value: StockAvailability,
            },
        ],
    },
    UI.Facets                    : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet2',
            Label : 'General Information Copia',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.HeaderFacets              : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.DataPoint#AverageRating'
    }],
    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Label: '{i18n>ImageUrl}',
            Value: ImageUrl,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>ProductName}',
            Value: ProductName,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>Description}',
            Value: Description,
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Label : '{i18n>Supplier}',
            Target: 'Supplier/@Communication.Contact'
        },
        {
            $Type: 'UI.DataField',
            Label: 'Fecha de lanzamiento',
            Value: ReleaseDate,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Fecha de descontinuación',
            Value: DiscontinuedDate,
        },
        {
            Label      : '{i18n>StockAvailability}',
            Value      : StockAvailability,
            Criticality: StockAvailability,
        },
        {
            //$Type: 'UI.DataField',
            Label : '{i18n>Rating}',
            //Value: Rating,
            $Type : 'UI.DataFieldForAnnotation',
            Target: '@UI.DataPoint#AverageRating'
        },
        {
            $Type: 'UI.DataField',
            Label: 'Precio',
            Value: Price,
        },
    ],
);


annotate service.Products with {
    CategoryId @title : 'Categoría';
    CurrencyId @title : 'Moneda';
    StockAvailability @title : 'Disponibilidad de stock';
    ImageUrl @title : 'Imágen';
    ProductName @title : 'Nombre producto';
    Description @title : 'Descripción';
    Supplier @title : 'Proveedor';
    ReleaseDate @title : 'Fecha de lanzamiento';
    DiscontinuedDate @title : 'Fecha de descontinuación';
    Rating @title : 'Valoración';
    Price @title : 'Precio';
    Quantity @title : 'Cantidad';
    Height @title : 'Alto';
    Width @title : 'Ancho';
    Depth @title : 'Profundo';
    ToDimensionUnit @title : 'Unidad de medida';
    ToCategory @title : 'Categoría';
    ToCurrency @title : 'Moneda';
    ToStockAvailability @title : 'Disponibilidad de stock';
};


annotate service.Products with {
    ToDimensionUnit @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'VH_DimensionUnits',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: ToDimensionUnit_ID,
                ValueListProperty: 'Code',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Text',
            },
        ],
    }
};

annotate service.Products with {
    Supplier @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Supplier',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: Supplier_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Name',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Email',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Phone',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Fax',
            },
        ],
    }
};

annotate service.Products with {
    ImageUrl @(UI.IsImageURL: true);
};


/*
* Annotation for Search Help
*/
annotate service.Products with {
    //Category
    CategoryId        @(Common: {
        Text     : {
            $value                : Category,
            ![@UI.TextArrangement]: #TextOnly
        },
        ValueList: {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_Categories',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: ToCategory_ID,
                    ValueListProperty: 'Code'
                },
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: ToCategory_ID,
                    ValueListProperty: 'Text'
                }
            ]
        },
    });

    //Currency
    CurrencyId        @(Common: {
        ValueListWithFixedValues: false,
        ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_Currencies',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: ToCurrency_ID,
                    ValueListProperty: 'Code'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Text'
                }
            ]
        },
    });

    //StockAvailability
    StockAvailability @(Common: {
        ValueListWithFixedValues: true,
        ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'StockAvailability',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: StockAvailability,
                ValueListProperty: 'Code'
            }]
        },
    })
};


/*
* Annotation for VH_Categories Entity
*/
annotate service.VH_Categories with {
    Code @(
        UI    : {
            title : '{i18n>Category}',
            Hidden: true
        },
        Common: {Text: {
            $value                : Text,
            ![@UI.TextArrangement]: #TextOnly
        }}
    );
    Text @(UI: {HiddenFilter: true});
};


/*
* Annotation for VH_Currencies Entity
*/
annotate service.VH_Currencies with {
    Code @(UI: {HiddenFilter: true});
    Text @(UI: {HiddenFilter: true});
};


/*
* Annotation for StockAvailability Entity
*/
annotate service.StockAvailability with {
    Code @(Common: {Text: {
        $value                : Text,
        ![@UI.TextArrangement]: #TextOnly
    }});
};


/*
* Annotation for VH_DimensionUnits Entity
*/
annotate service.VH_DimensionUnits with {
    Code @(UI: {HiddenFilter: true});
    Text @(UI: {HiddenFilter: true});
};


/*
* Annotation for VH_UnitOfMeasure Entity
*/
annotate service.VH_UnitOfMeasure with {
    Code @(UI: {HiddenFilter: true});
    Text @(UI: {HiddenFilter: true});
};


/*
* Annotation for Supplier Entity
*/
annotate service.Supplier with @Communication: {Contact: {
    $Type: 'Communication.ContactType',
    fn   : Name,
    role : 'Supplier - Role',
    photo: 'sap-icon://supplier',
    email: [{
        type   : #work,
        address: Email
    }],
    tel  : [
        {
            type: #work,
            uri : Phone
        },
        {
            type: #work,
            uri : Fax
        }
    ]
}};


/*
* Data Point for Average Rating
*/
annotate service.Products with @(UI.DataPoint #AverageRating: {
    Value        : Rating,
    Title        : 'Rating',
    TargetValue  : 5,
    Visualization: #Rating
});

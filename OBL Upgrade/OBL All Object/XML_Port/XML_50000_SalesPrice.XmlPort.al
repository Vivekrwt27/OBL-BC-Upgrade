xmlport 50000 "Sales Price"
{
    Direction = Import;
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Price)
        {
            tableelement("Item Sales Price1"; 50009)
            {
                XmlName = 'Salesprice';
                fieldelement(st; "Item Sales Price1"."Sales Type")
                {
                }
                fieldelement(Salescode; "Item Sales Price1"."Sales Code")
                {
                }
                fieldelement(itemclass; "Item Sales Price1"."Item Classification No.")
                {
                }
                fieldelement(uom; "Item Sales Price1"."Unit of Measure Code")
                {
                }
                fieldelement(mrp; "Item Sales Price1".MRP)
                {
                }
                fieldelement(unitprice; "Item Sales Price1"."Unit Price")
                {
                }
                fieldelement(sd; "Item Sales Price1"."Starting Date")
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}


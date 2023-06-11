xmlport 50001 Item_data
{
    Direction = Import;
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Itemdata)
        {
            tableelement("Item Templ."; 50030)
            {
                XmlName = 'Itemimportdata';
                fieldelement(a; "Item Templ."."No.")
                {
                }
                fieldelement(b; "Item Templ.".Description)
                {
                }
                fieldelement(c; "Item Templ."."Description 2")
                {
                }
                fieldelement(d; "Item Templ."."Excise Prod. Posting Group")
                {
                }
                fieldelement(e; "Item Templ."."Gen. Prod. Posting Group")
                {
                }
                fieldelement(f; "Item Templ."."Inventory Posting Group")
                {
                }
                fieldelement(g; "Item Templ."."Tax Group Code")
                {
                }
                fieldelement(h; "Item Templ."."Item Category Code")
                {
                }
                fieldelement(i; "Item Templ."."Base Unit of Measure")
                {
                }
                fieldelement(j; "Item Templ."."Replenishment System")
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


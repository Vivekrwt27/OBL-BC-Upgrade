xmlport 50064 "Temp Import"
{
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Posted Power & Fuel Cons. Hdr."; 50108)
            {
                XmlName = 'Weight';
                fieldelement(ItemNo; "Posted Power & Fuel Cons. Hdr."."No.")
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


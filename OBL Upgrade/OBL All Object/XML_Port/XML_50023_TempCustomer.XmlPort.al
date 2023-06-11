xmlport 50023 "Temp Customer"
{
    Direction = Export;
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Itemdata)
        {
            tableelement(Customer; 18)
            {
                XmlName = 'Itemimportdata';
                fieldelement(a; Customer."No.")
                {
                }
                fieldelement(b; Customer."PCH Code")
                {
                }
                fieldelement(c; Customer."Zonal Manager")
                {
                }
                fieldelement(d; Customer."Zonal Head")
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


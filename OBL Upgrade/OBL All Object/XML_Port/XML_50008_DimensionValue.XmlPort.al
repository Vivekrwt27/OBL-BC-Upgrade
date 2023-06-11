xmlport 50008 "Dimension Value"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(dimension)
        {
            tableelement("Dimension Value"; 349)
            {
                XmlName = 'dimensionvaluee';
                fieldelement(ab; "Dimension Value"."Dimension Code")
                {
                }
                fieldelement(bc; "Dimension Value".Code)
                {
                }
                fieldelement(cd; "Dimension Value".Name)
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


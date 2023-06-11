xmlport 50015 "Customer Credit History"
{
    Direction = Import;
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(custhistory)
        {
            XmlName = 'custhistory';
            tableelement("Customer Credit History"; 50072)
            {
                XmlName = 'Salesprice';
                fieldelement(custno; "Customer Credit History"."Customer No.")
                {
                }
                fieldelement(date; "Customer Credit History"."Starting date")
                {
                }
                fieldelement(creditlimit; "Customer Credit History"."Credit Limit (LCY)")
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


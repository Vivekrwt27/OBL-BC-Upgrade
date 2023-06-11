xmlport 50055 "discount Setup"
{
    Direction = Import;
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Price)
        {
            tableelement("Discount Setups"; 50095)
            {
                XmlName = 'Salesprice';
                fieldelement(st; "Discount Setups"."Area Code")
                {
                }
                fieldelement(sc; "Discount Setups".State)
                {
                }
                fieldelement(sn; "Discount Setups"."Customer No.")
                {
                }
                fieldelement(ic; "Discount Setups"."Item Classification")
                {
                }
                fieldelement(ms; "Discount Setups"."Manuf. Strategy")
                {
                }
                fieldelement(pd; "Discount Setups"."PreApproved Discount")
                {
                }
                fieldelement(da; "Discount Setups"."Discount on Approval")
                {
                }
                fieldelement(st; "Discount Setups"."Starting Date")
                {
                }
                fieldelement(ed; "Discount Setups"."Ending Date")
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


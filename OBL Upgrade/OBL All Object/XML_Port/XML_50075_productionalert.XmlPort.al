xmlport 50075 "production alert"
{
    // TECPRO7.10.01 #TEC.RS #<<23-04-2015>>
    //   # Upgrade From NAV 6 SP1 IN to NAV 2013 R2 IN"

    Direction = Both;
    FieldSeparator = '<TAB>';
    Format = VariableText;
    UseRequestPage = true;

    schema
    {
        textelement(ROOT)
        {
            tableelement("Item Amount 4"; 50021)
            {
                AutoSave = true;
                AutoUpdate = true;
                XmlName = 'GenJournalLine';
                UseTemporary = false;
                fieldelement(GJL22; "Item Amount 4"."Item No.")
                {
                }
                fieldelement(GJL10; "Item Amount 4".Date)
                {
                }
                fieldelement(GJL4; "Item Amount 4".Quantity)
                {
                }
                fieldelement(GJL25; "Item Amount 4"."Location Code")
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

    var
        IUOM: Record "Item Unit of Measure";
}


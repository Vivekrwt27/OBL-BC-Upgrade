xmlport 50070 "Item Journal Opening"
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
            tableelement("Item Journal Line"; 83)
            {
                AutoSave = true;
                AutoUpdate = true;
                XmlName = 'IJL';
                UseTemporary = false;
                fieldelement(GJL1; "Item Journal Line"."Journal Template Name")
                {
                }
                fieldelement(GJL3; "Item Journal Line"."Journal Batch Name")
                {
                }
                fieldelement(GJL17; "Item Journal Line"."Entry Type")
                {
                }
                fieldelement(GJL14; "Item Journal Line"."Document No.")
                {
                }
                fieldelement(GJL2; "Item Journal Line"."Line No.")
                {
                }
                fieldelement(GJL9; "Item Journal Line"."Posting Date")
                {
                }
                fieldelement(GJL4; "Item Journal Line"."Item No.")
                {
                }
                fieldelement(GJL6; "Item Journal Line".Description)
                {
                }
                fieldelement(GJL7; "Item Journal Line".Quantity)
                {
                }
                fieldelement(GJL8; "Item Journal Line"."Unit Cost")
                {
                }
                fieldelement(GJL10; "Item Journal Line"."Unit of Measure Code")
                {
                }
                fieldelement(GJL12; "Item Journal Line"."Shortcut Dimension 2 Code")
                {
                }
                fieldelement(GJL11; "Item Journal Line"."Shortcut Dimension 1 Code")
                {
                }
                fieldelement(GJL13; "Item Journal Line"."Location Code")
                {
                }
                fieldelement(GJL16; "Item Journal Line".Amount)
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


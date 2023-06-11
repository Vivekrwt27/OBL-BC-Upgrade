xmlport 50071 "Party Balances"
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
            tableelement("Gen. Journal Line"; 81)
            {
                AutoSave = true;
                AutoUpdate = true;
                XmlName = 'GenJournalLine';
                UseTemporary = false;
                fieldelement(GJL22; "Gen. Journal Line"."Journal Template Name")
                {
                }
                fieldelement(GJL10; "Gen. Journal Line"."Journal Batch Name")
                {
                }
                fieldelement(GJL4; "Gen. Journal Line"."Posting Date")
                {
                }
                fieldelement(GJL25; "Gen. Journal Line"."Document Date")
                {
                }
                fieldelement(GJL24; "Gen. Journal Line"."Line No.")
                {
                }
                fieldelement(GJL5; "Gen. Journal Line"."Document Type")
                {
                }
                fieldelement(GJL6; "Gen. Journal Line"."Document No.")
                {
                }
                fieldelement(GJL1; "Gen. Journal Line"."Account Type")
                {
                }
                fieldelement(GJL2; "Gen. Journal Line"."Account No.")
                {
                }
                fieldelement(GJL3; "Gen. Journal Line".Narration)
                {
                }
                fieldelement(GJL23; "Gen. Journal Line".Amount)
                {
                }
                fieldelement(GJL11; "Gen. Journal Line"."Bal. Account Type")
                {
                }
                fieldelement(GJL12; "Gen. Journal Line"."Bal. Account No.")
                {
                }
                fieldelement(GJL16; "Gen. Journal Line"."Due Date")
                {
                }
                fieldelement(GJL18; "Gen. Journal Line"."Currency Code")
                {
                }
                fieldelement(GJL19; "Gen. Journal Line"."External Document No.")
                {
                }
                fieldelement(GJL21; "Gen. Journal Line"."Location Code")
                {
                }
                fieldelement(GJL20; "Gen. Journal Line"."Shortcut Dimension 1 Code")
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


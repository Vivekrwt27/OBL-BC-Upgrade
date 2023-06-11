xmlport 70005 "G/L Balances"
{
    // TECPRO7.10.01 #TEC.RS #<<23-04-2015>>
    //   # Upgrade From NAV 6 SP1 IN to NAV 2013 R2 IN"

    DefaultFieldsValidation = false;
    Direction = Both;
    FieldSeparator = '<,>';
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
                fieldelement(GJL1; "Gen. Journal Line"."Line No.")
                {
                }
                fieldelement(GJL2; "Gen. Journal Line"."Journal Template Name")
                {
                }
                fieldelement(GJL3; "Gen. Journal Line"."Journal Batch Name")
                {
                }
                fieldelement(GJL4; "Gen. Journal Line"."Account Type")
                {
                }
                fieldelement(GJL5; "Gen. Journal Line"."Account No.")
                {
                }
                fieldelement(GJL6; "Gen. Journal Line".Narration)
                {
                }
                fieldelement(GJL7; "Gen. Journal Line"."Document No.")
                {
                }
                fieldelement(GJL8; "Gen. Journal Line"."Source Code")
                {
                }
                fieldelement(GJL9; "Gen. Journal Line"."Bal. Account Type")
                {
                }
                fieldelement(GJL10; "Gen. Journal Line"."Bal. Account No.")
                {
                }
                fieldelement(GJL11; "Gen. Journal Line".Amount)
                {
                }
                fieldelement(GJL12; "Gen. Journal Line"."Debit Amount")
                {
                }
                fieldelement(GJL13; "Gen. Journal Line"."Credit Amount")
                {
                }
                fieldelement(GJL14; "Gen. Journal Line"."Shortcut Dimension 1 Code")
                {
                }
                fieldelement(GJL15; "Gen. Journal Line"."Shortcut Dimension 2 Code")
                {
                }
                fieldelement(GJL16; "Gen. Journal Line"."External Document No.")
                {
                }
                fieldelement(GJL17; "Gen. Journal Line"."Document Date")
                {
                }
                fieldelement(GJL18; "Gen. Journal Line"."Posting Date")
                {
                }
                fieldelement(GJL21; "Gen. Journal Line"."Currency Code")
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


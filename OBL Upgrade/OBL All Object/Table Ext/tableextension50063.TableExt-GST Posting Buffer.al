tableextension 50063 tableextension50063 extends "GST Posting Buffer"
{
    fields
    {
        modify(Type)
        {
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
        }
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Gen. Bus. Posting Group';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        modify("GST Component Code")
        {
            Caption = 'GST Component Code';
        }
        modify("GST Reverse Charge")
        {
            Caption = 'GST Reverse Charge';
        }
        modify("GST Group Code")
        {
            Caption = 'GST Group Code';
        }
        modify("Party Code")
        {
            Caption = 'Party Code';
        }
        modify("GST Base Amount")
        {
            Caption = 'GST Base Amount';
        }
        modify("GST %")
        {
            Caption = 'GST %';
        }
        modify("GST Amount")
        {
            Caption = 'GST Amount';
        }
        modify("Interim Amount")
        {
            Caption = 'Interim Amount';
        }
        modify("Global Dimension 1 Code")
        {
            Caption = 'Global Dimension 1 Code';
        }
        modify("Global Dimension 2 Code")
        {
            Caption = 'Global Dimension 2 Code';
        }
        modify("Account No.")
        {
            Caption = 'Account No.';
        }
        modify("Interim Account No.")
        {
            Caption = 'Interim Account No.';
        }
        modify("Bal. Account No.")
        {
            Caption = 'Bal. Account No.';
        }
        modify("Transaction Type")
        {
            Caption = 'Transaction Type';
            OptionCaption = 'Sales,Purchase,Charge';
        }
        modify("GST Group Type")
        {
            Caption = 'GST Group Type';
            OptionCaption = ' ,Goods,Service';
        }
        modify("Custom Duty Amount")
        {
            Caption = 'Custom Duty Amount';
        }
        modify("Dimension Set ID")
        {
            Caption = 'Dimension Set ID';
        }
    }
}


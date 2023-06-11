tableextension 50083 tableextension50083 extends "Service Transfer Rcpt. Line"
{
    fields
    {
        modify("Document No.")
        {
            Caption = 'Document No.';
        }
        modify("Line No.")
        {
            Caption = 'Line No.';
        }
        modify("Transfer From G/L Account No.")
        {
            Caption = 'Transfer From G/L Account No.';
        }
        modify("Transfer To G/L Account No.")
        {
            Caption = 'Transfer To G/L Account No.';
        }
        modify("Transfer Price")
        {
            Caption = 'Transfer Price';
        }
        modify("Ship Control A/C No.")
        {
            Caption = 'Ship Control A/C No.';
        }
        modify("Receive Control A/C No.")
        {
            Caption = 'Receive Control A/C No.';
        }
        modify(Shipped)
        {
            Caption = 'Shipped';
        }
        modify("Shortcut Dimension 1 Code")
        {
            Caption = 'Shortcut Dimension 1 Code';
        }
        modify("Shortcut Dimension 2 Code")
        {
            Caption = 'Shortcut Dimension 2 Code';
        }
        modify("GST Group Code")
        {
            Caption = 'GST Group Code';
        }
        modify("SAC Code")
        {
            Caption = 'SAC Code';
        }
        /* modify("GST Base Amount")
         {
             Caption = 'GST Base Amount';
         }
         modify("GST %")
         {
             Caption = 'GST %';
         }
         modify("Total GST Amount")
         {
             Caption = 'Total GST Amount';
         }*/ // 15578
        modify("GST Rounding Type")
        {
            Caption = 'GST Rounding Type';
        }
        modify("GST Rounding Precision")
        {
            Caption = 'GST Rounding Precision';
        }
        modify("From G/L Account Description")
        {
            Caption = 'From G/L Account Description';
        }
        modify("To G/L Account Description")
        {
            Caption = 'To G/L Account Description';
        }
        modify("Dimension Set ID")
        {
            Caption = 'Dimension Set ID';
        }
    }
}


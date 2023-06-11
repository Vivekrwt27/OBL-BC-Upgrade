tableextension 50066 tableextension50066 extends "GST Application Buffer"
{
    fields
    {
        modify("Transaction Type")
        {
            Caption = 'Transaction Type';
            OptionCaption = 'Purchase,Sale';
        }
        modify("Original Document Type")
        {
            Caption = 'Original Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Payment,Refund';
        }
        modify("Original Document No.")
        {
            Caption = 'Original Document No.';
        }
        modify("HSN/SAC Code")
        {
            Caption = 'HSN/SAC Code';
        }
        modify("GST Component Code")
        {
            Caption = 'GST Component Code';
        }
        modify("GST Base Amount")
        {
            Caption = 'GST Base Amount';
        }
        modify("GST Amount")
        {
            Caption = 'GST Amount';
        }
        modify("Applied Doc. Type")
        {
            Caption = 'Applied Doc. Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Payment,Refund';
        }
        modify("Applied Doc. No.")
        {
            Caption = 'Applied Doc. No.';
        }
        modify("Applied Amount")
        {
            Caption = 'Applied Amount';
        }
        modify("Current Doc. Type")
        {
            Caption = 'Current Doc. Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Payment,Refund';
        }
        modify("Transaction No.")
        {
            Caption = 'Transaction No.';
        }
        modify("Application Type")
        {
            Caption = 'Application Type';
            OptionCaption = 'Online,Offline';
        }
        modify("Applied Doc. Type(Posted)")
        {
            Caption = 'Applied Doc. Type(Posted)';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Payment,Refund';
        }
        modify("Applied Doc. No.(Posted)")
        {
            Caption = 'Applied Doc. No.(Posted)';
        }
        modify("GST Group Type")
        {
            Caption = 'GST Group Type';
            OptionCaption = ' ,Goods,Service';
        }
        modify("CLE/VLE Entry No.")
        {
            Caption = 'CLE/VLE Entry No.';
        }
        modify("Account No.")
        {
            Caption = 'Account No.';
        }
        modify("Applied Base Amount")
        {
            Caption = 'Applied Base Amount';
        }
        modify("GST Cess")
        {
            Caption = 'GST Cess';
        }
        modify("Charge To Cust/Vend")
        {
            Caption = 'Charge To Cust/Vend';
        }
        modify("Currency Code")
        {
            Caption = 'Currency Code';
        }
        modify("Currency Factor")
        {
            Caption = 'Currency Factor';
        }
        modify("GST Rounding Precision")
        {
            Caption = 'GST Rounding Precision';
        }
        modify("GST Rounding Type")
        {
            Caption = 'GST Rounding Type';
            OptionCaption = 'Nearest,Up,Down';
        }
        modify("TDS/TCS Amount")
        {
            Caption = 'TDS/TCS Amount';
        }
        modify("GST Credit")
        {
            Caption = 'GST Credit';
        }
        modify("GST Group Code")
        {
            Caption = 'GST Group Code';
        }
    }
}


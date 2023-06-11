tableextension 50060 tableextension50060 extends "Detailed GST Entry Buffer"
{
    Caption = 'Detailed GST Entry Buffer';
    fields
    {
        modify("Entry No.")
        {
            Caption = 'Entry No.';
        }
        modify("Document Type")
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
        }
        modify("Document No.")
        {
            Caption = 'Document No.';
        }
        modify("Posting Date")
        {
            Caption = 'Posting Date';
        }
        modify(Type)
        {
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
        }
        modify("No.")
        {
            Caption = 'No.';
        }
        modify("Product Type")
        {
            Caption = 'Product Type';
            OptionCaption = ' ,Item,Capital Goods';
        }
        modify("Source No.")
        {
            Caption = 'Source No.';
        }
        modify("GST Component Code")
        {
            Caption = 'GST Component Code';
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
        modify(Quantity)
        {
            Caption = 'Quantity';
        }
        modify("GST Group Code")
        {
            Caption = 'GST Group Code';
        }
        modify("HSN/SAC Code")
        {
            Caption = 'HSN/SAC Code';
        }
        modify("GST Input/Output Credit Amount")
        {
            Caption = 'GST Input/Output Credit Amount';
        }
        modify("Amount Loaded on Item")
        {
            Caption = 'Amount Loaded on Item';
        }
        modify("Location Code")
        {
            Caption = 'Location Code';
        }
        modify("Line No.")
        {
            Caption = 'Line No.';
        }
        modify("Item Charge Assgn. Line No.")
        {
            Caption = 'Item Charge Assgn. Line No.';
        }
        modify("GST on Advance Payment")
        {
            Caption = 'GST on Advance Payment';
        }
        modify("Reverse Charge")
        {
            Caption = 'Reverse Charge';
        }
        modify("Item Charge Assgn. Doc. Type")
        {
            Caption = 'Item Charge Assgn. Doc. Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Receipt,Transfer Receipt,Return Shipment,Sales Shipment,Return Receipt';
        }
        modify("Item Charge Assgn Doc. No.")
        {
            Caption = 'Item Charge Assgn Doc. No.';
        }
        modify("Journal Template Name")
        {
            Caption = 'Journal Template Name';
        }
        modify("Journal Batch Name")
        {
            Caption = 'Journal Batch Name';
        }
        modify("Bill Of Export No.")
        {
            Caption = 'Bill Of Export No.';
        }
        modify("Bill Of Export Date")
        {
            Caption = 'Bill Of Export Date';
        }
        modify("e-Comm. Merchant Id")
        {
            Caption = 'e-Comm. Merchant Id';
        }
        modify("e-Comm. Operator GST Reg. No.")
        {
            Caption = 'e-Comm. Operator GST Reg. No.';
        }
        modify("Invoice Type")
        {
            Caption = 'Invoice Type';
        }
        modify("Original Invoice No.")
        {
            Caption = 'Original Invoice No.';
        }
        modify("Original Invoice Date")
        {
            Caption = 'Original Invoice Date';
        }
        modify("Adv. Pmt. Adjustment")
        {
            Caption = 'Adv. Pmt. Adjustment';
        }
        modify("Original Adv. Pmt Doc. No.")
        {
            Caption = 'Original Adv. Pmt Doc. No.';
        }
        modify("Original Adv. Pmt Doc. Date")
        {
            Caption = 'Original Adv. Pmt Doc. Date';
        }
        modify(Cess)
        {
            Caption = 'Cess';
        }
        modify("GST Group Type")
        {
            Caption = 'GST Group Type';
            OptionCaption = 'Goods,Service';
        }
        modify("Buyer/Seller State Code")
        {
            Caption = 'Buyer/Seller State Code';
        }
        modify("Shipping Address State Code")
        {
            Caption = 'Shipping Address State Code';
        }
        modify("Location State Code")
        {
            Caption = 'Location State Code';
        }
        modify("Location  Reg. No.")
        {
            Caption = 'Location  Reg. No.';
        }
        modify("Buyer/Seller Reg. No.")
        {
            Caption = 'Buyer/Seller Reg. No.';
        }
        modify("GST Place of Supply")
        {
            Caption = 'GST Place of Supply';
            OptionCaption = ' ,Bill-to Address,Ship-to Address,Location Address';
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
        modify("GST Base Amount (LCY)")
        {
            Caption = 'GST Base Amount (LCY)';
        }
        modify("GST Amount (LCY)")
        {
            Caption = 'GST Amount (LCY)';
        }
        modify("TDS/TCS Amount")
        {
            Caption = 'TDS/TCS Amount';
        }
        modify("Input Service Distribution")
        {
            Caption = 'Input Service Distribution';
        }
        modify(Inward)
        {
            Caption = 'Inward';
        }
        modify(Exempted)
        {
            Caption = 'Exempted';
        }
    }
    keys
    {
        key(Key4; "Document Type", "Document No.", "Transaction Type", "Line No.")
        {
        }
        key(Key5; "Transaction Type", "Journal Template Name", "Journal Batch Name", "Line No.", "GST TDS")
        {
        }
    }
}


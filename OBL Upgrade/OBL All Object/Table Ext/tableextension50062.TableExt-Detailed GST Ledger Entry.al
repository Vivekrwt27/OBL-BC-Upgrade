tableextension 50062 tableextension50062 extends "Detailed GST Ledger Entry"
{
    fields
    {
        modify("Entry No.")
        {
            Caption = 'Entry No.';
        }
        modify("Entry Type")
        {
            Caption = 'Entry Type';
        }
        modify("Transaction Type")
        {
            Caption = 'Transaction Type';
            OptionCaption = 'Purchase,Sales,Transfer,Settlement';
        }
        modify("Document Type")
        {
            OptionCaption = ' ,Payment,Invoice,Credit Memo,,,,Refund';
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
        modify("HSN/SAC Code")
        {
            Caption = 'HSN/SAC Code';
        }
        modify("GST Component Code")
        {
            Caption = 'GST Component Code';
        }
        modify("GST Group Code")
        {
            Caption = 'GST Group Code';
        }
        modify("GST Jurisdiction Type")
        {
            Caption = 'GST Jurisdiction Type';
            OptionCaption = 'Intrastate,Interstate';
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
        modify("External Document No.")
        {
            Caption = 'External Document No.';
        }
        modify("Amount Loaded on Item")
        {
            Caption = 'Amount Loaded on Item';
        }
        modify(Quantity)
        {
            Caption = 'Quantity';
        }
        modify("GST Without Payment of Duty")
        {
            Caption = 'GST Without Payment of Duty';
        }
        modify("G/L Account No.")
        {
            Caption = 'G/L Account No.';
        }
        modify("Reversed by Entry No.")
        {
            Caption = 'Reversed by Entry No.';
        }
        modify(Reversed)
        {
            Caption = 'Reversed';
        }
        modify("Document Line No.")
        {
            Caption = 'Document Line No.';
        }
        modify("Item Charge Entry")
        {
            Caption = 'Item Charge Entry';
        }
        modify("Reverse Charge")
        {
            Caption = 'Reverse Charge';
        }
        modify("GST on Advance Payment")
        {
            Caption = 'GST on Advance Payment';
        }
        modify("Payment Document No.")
        {
            Caption = 'Payment Document No.';
        }
        modify("GST Exempted Goods")
        {
            Caption = 'GST Exempted Goods';
        }
        modify("Location  Reg. No.")
        {
            Caption = 'Location  Reg. No.';
        }
        modify("Buyer/Seller Reg. No.")
        {
            Caption = 'Buyer/Seller Reg. No.';
        }
        modify("GST Group Type")
        {
            Caption = 'GST Group Type';
            OptionCaption = 'Goods,Service';
        }
        modify("GST Credit")
        {
            Caption = 'GST Credit';
            OptionCaption = ' ,Availment,Non-Availment';
        }
        modify("Reversal Entry")
        {
            Caption = 'Reversal Entry';
        }
        modify("Transaction No.")
        {
            Caption = 'Transaction No.';
        }
        modify("Currency Code")
        {
            Caption = 'Currency Code';
        }
        modify("Currency Factor")
        {
            Caption = 'Currency Factor';
        }
        modify("Application Doc. Type")
        {
            Caption = 'Application Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Transfer,Finance Charge Memo,Reminder,Refund';
        }
        modify("Application Doc. No")
        {
            Caption = 'Application Doc. No';
        }
        modify("Applied From Entry No.")
        {
            Caption = 'Applied From Entry No.';
        }
        modify("Reversed Entry No.")
        {
            Caption = 'Reversed Entry No.';
        }
        modify("Remaining Closed")
        {
            Caption = 'Remaining Closed';
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
        modify("Location Code")
        {
            Caption = 'Location Code';
        }
        modify("GST Customer Type")
        {
            Caption = 'GST Customer Type';
        }
        modify("GST Vendor Type")
        {
            Caption = 'GST Vendor Type';
        }
        modify("Original Invoice No.")
        {
            Caption = 'Original Invoice No.';
        }
        modify("Reconciliation Month")
        {
            Caption = 'Reconciliation Month';
        }
        modify("Reconciliation Year")
        {
            Caption = 'Reconciliation Year';
        }
        modify(Reconciled)
        {
            Caption = 'Reconciled';
        }
        modify("Credit Availed")
        {
            Caption = 'Credit Availed';
        }
        modify(Paid)
        {
            Caption = 'Paid';
        }
        modify("Credit Adjustment Type")
        {
            Caption = 'Credit Adjustment Type';
        }
        modify("GST Place of Supply")
        {
            Caption = 'GST Place of Supply';
            OptionCaption = ' ,Bill-to Address,Ship-to Address,Location Address';
        }
        modify("Payment Type")
        {
            Caption = 'Payment Type';
        }
        modify(Distributed)
        {
            Caption = 'Distributed';
        }
        modify("Distributed Reversed")
        {
            Caption = 'Distributed Reversed';
        }
        modify("Input Service Distribution")
        {
            Caption = 'Input Service Distribution';
        }
        modify(Opening)
        {
            Caption = 'Opening';
        }
        modify("Remaining Base Amount")
        {
            Caption = 'Remaining Base Amount';

            //Unsupported feature: Property Modification (Editable) on ""Remaining Base Amount"(Field 109)".

        }
        modify("Remaining GST Amount")
        {
            Caption = 'Remaining GST Amount';

            //Unsupported feature: Property Modification (Editable) on ""Remaining GST Amount"(Field 110)".

        }
        field(50000; "Org. GST Group Type"; Option)
        {
            OptionCaption = 'Goods,Service';
            OptionMembers = Goods,Service;
        }
        field(50001; "RCM Party GST No."; Code[18])
        {
        }
        field(50002; "Unit of Measure"; Code[10])
        {
            CalcFormula = Lookup(Item."Base Unit of Measure" WHERE("No." = FIELD("No.")));
            Enabled = false;
            FieldClass = FlowField;
        }
        field(50003; "Item Desc"; Text[30])
        {
        }
        field(50004; "Item Desc2"; Text[30])
        {
        }
        field(50005; "ITC Type"; Option)
        {
            CalcFormula = Lookup("Purch. Inv. Line"."ITC Type" WHERE("Buy-from Vendor No." = FIELD("Source No."),
                                                                      "No." = FIELD("No.")));
            Enabled = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Input Goods,Input Servce,Input Capital Goods,NON ITC';
            OptionMembers = " ","Input Goods","Input Servce","Input Capital Goods","NON ITC";
        }
        field(50006; "Vender Inv Date"; Date)
        {
            CalcFormula = Lookup("Purch. Inv. Header"."Vendor Invoice Date" WHERE("No." = FIELD("Document No.")));
            Enabled = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key30; "Document No.", "Posting Date")
        {
        }
    }

}


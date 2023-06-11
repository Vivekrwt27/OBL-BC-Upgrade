pageextension 50102 pageextension50102 extends "Journal Bank Charges"
{
    layout
    {
        movebefore(GroupName; "Bank Charge", "GST Document Type", Amount, "Amount (LCY)", "GST Group Code", "Foreign Exchange", "HSN/SAC Code", Exempted, "GST Credit", "External Document No.", LCY)

        addfirst(Content)
        {
            field("GST Group Type"; rec."GST Group Type")
            {
                ApplicationArea = All;
            }
            field("GST Bill to/Buy From State"; rec."GST Bill to/Buy From State")
            {
                ApplicationArea = All;
            }
            field("GST Registration Status"; rec."GST Registration Status")
            {
                ApplicationArea = All;
            }
            field("GST Inv. Rounding Precision"; rec."GST Inv. Rounding Precision")
            {
                ApplicationArea = All;
            }
            field("GST Inv. Rounding Type"; rec."GST Inv. Rounding Type")
            {
                ApplicationArea = All;
            }
        }
    }

}


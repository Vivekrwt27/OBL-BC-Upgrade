pageextension 50194 pageextension50194 extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("GST Dependency Type")
        {
            field("Insurance Structure"; Rec."Insurance Structure")
            {
                ApplicationArea = all;
            }
            field("Structure Trade Discount"; Rec."Structure Trade Discount")
            {
                ApplicationArea = all;
            }
            field("Structure Frieght"; Rec."Structure Frieght")
            {
                ApplicationArea = all;
            }
            field("% of MRP"; Rec."% of MRP")
            {
                ApplicationArea = all;
            }
            field("Prompt Pmt. Account No."; Rec."Prompt Pmt. Account No.")
            {
                ApplicationArea = all;
            }
            field("Insurance Tax Charge Group"; Rec."Insurance Tax Charge Group")
            {
                ApplicationArea = all;
            }
            field("UP State Code"; Rec."UP State Code")
            {
                ApplicationArea = all;
            }
            field("Nepal Country Code"; Rec."Nepal Country Code")
            {
                ApplicationArea = all;
            }
            field("Bhutan Country Code"; Rec."Bhutan Country Code")
            {
                ApplicationArea = all;
            }
            field("Form Code For C-Form"; Rec."Form Code For C-Form")
            {
                ApplicationArea = all;
            }
            field("Cash Disc. Charge"; Rec."Cash Disc. Charge")
            {
                ApplicationArea = all;
            }
            field("Tax Area Code For UPTT"; Rec."Tax Area Code For UPTT")
            {
                ApplicationArea = all;
            }
            field("Tax Area Code For CST (Plant)"; Rec."Tax Area Code For CST (Plant)")
            {
                ApplicationArea = all;
            }
            field("Tax Jurisdiction Code For UPDT"; Rec."Tax Jurisdiction Code For UPDT")
            {
                ApplicationArea = all;
            }
            field("QD Applicable"; Rec."QD Applicable")
            {
                ApplicationArea = all;
            }

        }
        addafter("Posted Credit Memo Nos.")
        {
            field("Discount No."; Rec."Discount No.")
            {
                ApplicationArea = all;
            }
            field(City; Rec.City)
            {
                ApplicationArea = all;
            }
            field(States; Rec.States)
            {
                ApplicationArea = all;
            }
            field(Zone; Rec.Zone)
            {
                ApplicationArea = all;
            }
            field(Division; Rec.Division)
            {
                ApplicationArea = all;
            }
            field("Sales Matrix"; Rec."Sales Matrix")
            {
                ApplicationArea = all;
            }
            field(TempBoolean; Rec.TempBoolean)
            {
                ApplicationArea = all;
            }
            field("Area"; Rec."Area")
            {
                ApplicationArea = all;
            }
            field("NPD Count"; Rec."NPD Count")
            {
                ApplicationArea = all;
            }
            field("E-Way User Name"; Rec."E-Way User Name")
            {
                ApplicationArea = all;
            }
            field("E-Way Password"; Rec."E-Way Password")
            {
                ApplicationArea = all;
            }
            field("E-way Access Token"; Rec."E-way Access Token")
            {
                ApplicationArea = all;
            }
            field("E-way Access Token Validity"; Rec."E-way Access Token Validity")
            {
                ApplicationArea = all;
            }
            field("Inter Customer A/c"; Rec."Inter Customer A/c")
            {
                ApplicationArea = all;
            }
            field("D1 Approval Limit"; Rec."D1 Approval Limit")
            {
                ApplicationArea = all;
            }
            field("D2 Approval Limit"; Rec."D2 Approval Limit")
            {
                ApplicationArea = all;
            }
            field("D3 Approval Limit"; Rec."D3 Approval Limit")
            {
                ApplicationArea = all;
            }
            field("D4 Approval Limit"; Rec."D4 Approval Limit")
            {
                ApplicationArea = all;
            }
            field("PSM Code"; Rec."PSM Code")
            {
                ApplicationArea = all;
            }
            field("CD Account"; Rec."CD Account")
            {
                ApplicationArea = all;
            }
            field("Manual Credit Approval"; Rec."Manual Credit Approval")
            {
                ApplicationArea = all;
            }

        }
        moveafter("Default Quantity to Ship"; "Exact Cost Reversing Mandatory")
    }
    actions
    {

        addfirst(reporting)
        {
            action("Debtor Balance")
            {
                ApplicationArea = All;
            }



        }
    }
}


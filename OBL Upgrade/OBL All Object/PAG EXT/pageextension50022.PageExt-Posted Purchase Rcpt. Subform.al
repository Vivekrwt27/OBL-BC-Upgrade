pageextension 50022 pageextension50022 extends "Posted Purchase Rcpt. Subform"
{
    layout
    {
        addfirst(Control1)
        {
            field("Line No."; rec."Line No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Correction)
        {
            field("Accepted Qunatity"; rec."Accepted Qunatity")
            {
                ApplicationArea = All;
            }
            field("Actual Quantity"; rec."Actual Quantity")
            {
                ApplicationArea = All;
            }
            field("Challan Quantity"; rec."Challan Quantity")
            {
                ApplicationArea = All;
            }
            field("Shortage Quantity"; rec."Shortage Quantity")
            {
                ApplicationArea = All;
            }
            field("Rejected Quantity"; rec."Rejected Quantity")
            {
                ApplicationArea = All;
            }
            field("Orient MRP"; rec."Orient MRP")
            {
                ApplicationArea = All;
            }
            field("Capex No."; rec."Capex No.")
            {
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("Unit Cost (LCY)"; rec."Unit Cost (LCY)")
            {
                ApplicationArea = All;
            }
            field("Direct Unit Cost"; rec."Direct Unit Cost")
            {
                ApplicationArea = All;
            }

        }
    }
}


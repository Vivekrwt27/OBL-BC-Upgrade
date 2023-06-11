pageextension 50271 pageextension50271 extends "Get Receipt Lines"
{
    layout
    {
        addafter("Document No.")
        {
            field("Possible Cenvat"; Rec."Possible Cenvat")
            {
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
        }
        addafter("No.")
        {
            field("Capex No."; Rec."Capex No.")
            {
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            /* field("Excise Prod. Posting Group"; "Excise Prod. Posting Group")//16225 field N/F
             {
             }
             field("Excise Bus. Posting Group"; "Excise Bus. Posting Group")//16225 field N/F
             {
             }*/
            field(Name; Rec.Name)
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            /* field("Description 2"; Rec."Description 2")//16225 Field Allready Define Base Page
             {
             }*/
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
            }
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
            }
            field("Vendor Invoice No."; Rec."Vendor Invoice No.")
            {
                ApplicationArea = All;
            }
            field("Rejected Quantity"; Rec."Rejected Quantity")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shortcut Dimension 1 Code")
        {
            field("Direct Unit Cost"; Rec."Direct Unit Cost")
            {
                ApplicationArea = All;
            }
        }
    }
}


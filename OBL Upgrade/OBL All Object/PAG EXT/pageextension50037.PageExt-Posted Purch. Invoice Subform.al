pageextension 50037 pageextension50037 extends "Posted Purch. Invoice Subform"
{
    layout
    {

        addfirst(Control1)
        {
            field("Line No."; rec."Line No.")
            {
                ApplicationArea = All;
            }
            field("Excise Amount Per Unit"; rec."Excise Amount Per Unit")
            {
                ApplicationArea = All;
            }
            field("Capex No."; rec."Capex No.")
            {
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            /*  field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
             {
                 ApplicationArea = All;
             }
             field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
             {
                 ApplicationArea = All;
             }
             */
            field("Document No."; rec."Document No.")
            {
                ApplicationArea = All;
            }
            field("Orient MRP"; rec."Orient MRP")
            {
                ApplicationArea = All;
            }
            field("Location Code"; rec."Location Code")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Capex No."; "Tax Area Code", "Tax Group Code")
        addafter("Shortcut Dimension 2 Code")
        {
            field("Source Order No."; rec."Source Order No.")
            {
                ApplicationArea = All;
            }
            field("Item Category Code"; rec."Item Category Code")
            {
                ApplicationArea = All;
            }
            field("VAT Base Amount"; rec."VAT Base Amount")
            {
                ApplicationArea = All;
            }

        }
    }
}


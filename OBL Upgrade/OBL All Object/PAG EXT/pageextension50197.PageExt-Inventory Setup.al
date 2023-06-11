pageextension 50197 pageextension50197 extends "Inventory Setup"
{

    layout
    {
        addbefore("Copy Comments Order to Rcpt.")
        {
            field("Plant Code"; Rec."Plant Code")
            {
                ApplicationArea = all;
            }
            field("Quality Code"; Rec."Quality Code")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {

        addfirst(processing)
        {
            action("Export to Excel")
            {
                ApplicationArea = All;
            }

        }
    }
}


pageextension 50117 pageextension50117 extends "Gate Entry List"
{
    layout
    {
        addafter("No.")
        {
            field("Vehicle No."; rec."Vehicle No.")
            {
                ApplicationArea = All;
            }
            field("Vendor Name"; rec."Vendor Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("Location Code")
        {
            field("Reporting Date"; rec."Reporting Date")
            {
                ApplicationArea = All;
            }
            field("Reporting Time"; rec."Reporting Time")
            {
                ApplicationArea = All;
            }
            field("Vehicle In Time"; rec."Vehicle In Time")
            {
                ApplicationArea = All;
            }
            field("Vehicle Out Time"; rec."Vehicle Out Time")
            {
                ApplicationArea = All;
            }
        }
    }
}


pageextension 50385 pageextension50385 extends "Sales Order Archives"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Order Date"; Rec."Order Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }

    }

    var
        rcust: Record Customer;
        zone: Text[50];
        Territory: Text[50];

    trigger OnAfterGetRecord()
    begin
        IF rcust.GET(rec."Sell-to Customer No.") THEN
            zone := rcust."Tableau Zone";
        Territory := rcust."Area Code";

    end;


}


pageextension 50228 pageextension50228 extends "Sales Lines"
{
    layout
    {
        addafter("Outstanding Quantity")
        {
            field(ItemClass; ItemClass)
            {
                Caption = 'Item Class';
                ApplicationArea = All;
            }
            field("Reserved Quantity"; Rec."Reserved Quantity")
            {
                ApplicationArea = All;
            }
            field("Quantity Invoiced"; Rec."Quantity Invoiced")
            {
                ApplicationArea = All;
            }
            field("Unit Price"; Rec."Unit Price")
            {
                ApplicationArea = All;
            }
            field("Line Discount %"; Rec."Line Discount %")
            {
                ApplicationArea = All;
            }
            field("Line Discount Amount"; Rec."Line Discount Amount")
            {
                ApplicationArea = All;
            }
            field("Despatch Remarks"; Despatchremarks)
            {
                ApplicationArea = All;
            }
            field("Reason To Hold"; Reasontohold)
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        moveafter(ItemClass; "Description 2")
        moveafter("Reserved Quantity"; "Qty. to Ship")
    }

    var
        Itemrec: Record Item;
        ItemClass: Code[20];
        Despatchremarks: Text[50];
        Reasontohold: Text[50];
        SalesHeader: Record "Sales Header";

    trigger OnAfterGetRecord()
    begin
        //Upgrade(+)
        CreditApp := SalesHeader."Credit Approved";
        PriceApp := SalesHeader."Price Approved";
        InvApp := SalesHeader."Inventory Approved";
        Bypass := SalesHeader."Bypass Auto Order Process";

        // Msdr.begin
        IF Itemrec.GET(rec."No.") THEN
            ItemClass := Itemrec."Item Classification"
        ELSE
            ItemClass := '';
        // Msdr.end;

        //Upgrade(-)
        Despatchremarks := '';
        Reasontohold := '';

        IF SalesHeader.GET(rec."Document Type", rec."Document No.") THEN
            Despatchremarks := SalesHeader."Despatch Remarks";
        Reasontohold := SalesHeader.Commitment;

    end;

    var
        CreditApp: Boolean;
        PriceApp: Boolean;
        InvApp: Boolean;
        Bypass: Boolean;

}



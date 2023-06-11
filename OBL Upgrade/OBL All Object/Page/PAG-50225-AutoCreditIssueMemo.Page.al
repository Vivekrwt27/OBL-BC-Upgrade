page 50225 "Auto Credit Issue Memo"
{
    Editable = false;
    PageType = List;
    SourceTable = "Issued Credit Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Item Charge No."; Rec."Item Charge No.")
                {
                    ApplicationArea = All;
                }
                field("Cust. No."; Rec."Cust. No.")
                {
                    ApplicationArea = All;
                }
                field("Cust Name"; Rec."Cust Name")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Invoice Amount"; Rec."Invoice Amount")
                {
                    ApplicationArea = All;
                }
                field("Payment Amount"; Rec."Payment Amount")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("State Code"; Rec."State Code")
                {
                    ApplicationArea = All;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    TableRelation = "Sales Invoice Header"."No.";
                    ApplicationArea = All;
                }
                field("External Doc. No."; Rec."External Doc. No.")
                {
                    ApplicationArea = All;
                }
                field(Narration; Rec.Narration)
                {
                    ApplicationArea = All;
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Posting Date & Time"; Rec."Posting Date & Time")
                {
                    ApplicationArea = All;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        /*
        IssueCreditDetailsREC.RESET;
        IssueCreditDetailsREC.SETRANGE(IssueCreditDetailsREC."Document Type", IssueCreditDetailsREC."Document Type"::Payment);
        IF IssueCreditDetailsREC.FINDFIRST THEN
        REPEAT
           SalesInvoiceHeaderREC.RESET;
           SalesInvoiceHeaderREC.SETRANGE(SalesInvoiceHeaderREC."Order No.", IssueCreditDetailsREC."Sales Order No.");
           IF SalesInvoiceHeaderREC.FINDFIRST THEN BEGIN
               IssueCreditDetailsREC."Invoice No." := SalesInvoiceHeaderREC."No.";
               IssueCreditDetailsREC.MODIFY;
           END;
        UNTIL IssueCreditDetailsREC.NEXT=0;
         */

    end;

    var
        CustName: Text[100];
        CustRec: Record Customer;
        IssueCreditDetailsREC: Record "Issued Credit Details";
        SalesInvoiceHeaderREC: Record "Sales Invoice Header";
}


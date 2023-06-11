page 50120 "Accrued Discount Form"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Quantity Discount Entry";

    layout
    {
        area(content)
        {
            repeater(control)
            {
                field("Document Type"; REC."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Scheme Code"; Rec."Scheme Code")
                {
                    ApplicationArea = All;
                }
                field("Sell to Customer Code"; Rec."Sell to Customer Code")
                {
                    ApplicationArea = All;
                }
                field(CustName; CustName)
                {
                    Caption = 'Customer Name';
                    ApplicationArea = All;
                }
                field("Invoice Amount"; Rec."Invoice Amount")
                {
                    ApplicationArea = All;
                }
                field("Applicable Quantity"; Rec."Applicable Quantity")
                {
                    ApplicationArea = All;
                }
                field("Quantity Discount Accrued"; Rec."Quantity Discount Accrued")
                {
                    ApplicationArea = All;
                }
                field("QD Given Amount"; Rec."QD Given Amount")
                {
                    ApplicationArea = All;
                }
                field("Accrued Quantity"; Rec."Accrued Quantity")
                {
                    ApplicationArea = All;
                }
                field("Accrued Entry"; Rec."Accrued Entry")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        IF RecCust.GET(Rec."Sell to Customer Code") THEN
            CustName := RecCust.Name;
        DocumentTypeOnFormat;
        DocumentNoOnFormat;
        SchemeCodeOnFormat;
        SelltoCustomerCodeOnFormat;
        QDGivenAmountOnFormat;
        AccruedQuantityOnFormat;
    end;

    var
        RecCust: Record Customer;
        CustName: Text[60];

    local procedure DocumentTypeOnFormat()
    begin
        IF Rec."Accrued Entry" = TRUE THEN;
    end;

    local procedure DocumentNoOnFormat()
    begin
        IF Rec."Accrued Entry" = TRUE THEN;
    end;

    local procedure SchemeCodeOnFormat()
    begin
        IF Rec."Accrued Entry" = TRUE THEN;
    end;

    local procedure SelltoCustomerCodeOnFormat()
    begin
        IF Rec."Accrued Entry" = TRUE THEN;
    end;

    local procedure QDGivenAmountOnFormat()
    begin
        IF Rec."Accrued Entry" = TRUE THEN;
    end;

    local procedure AccruedQuantityOnFormat()
    begin
        IF Rec."Accrued Entry" = TRUE THEN;
    end;
}


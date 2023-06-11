pageextension 50304 pageextension50304 extends "Posted Sales Credit Memo"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        modify(GenerateIRN)
        {
            Visible = false;
        }
        modify("Cancel IRN")
        {
            Visible = false;
        }
        addafter("&Cr. Memo")
        {
            action("GenerateIRN1")
            {
                Caption = 'GenerateIRN';
                ApplicationArea = All;
                Promoted = true;
                trigger OnAction()
                var
                    SalesCreditMemoHeader: Record "Sales Cr.Memo Header";
                    EInvoice: Codeunit 50200;
                begin
                    IF rec."Posting Date" <= 20200930D THEN
                        ERROR('You cannot create IRN Before than 1st Oct 2020');
                    rec.TESTFIELD("Acknowledgement No.", '');
                    rec.TESTFIELD("Acknowledgement Date", 0DT);
                    CLEAR(EInvoice);
                    SalesCreditMemoHeader.RESET;
                    SalesCreditMemoHeader.SETFILTER("No.", '%1', rec."No.");
                    IF SalesCreditMemoHeader.FINDFIRST THEN BEGIN
                        EInvoice.SetCrMemoHeader(SalesCreditMemoHeader);
                        EInvoice.GenerateSalesCreditJSONSchema(SalesCreditMemoHeader);
                    END;
                end;
            }
            action("Cancel IRN1")
            {
                Caption = 'Cancel IRN';
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesCreditMemoHeader: Record "Sales Cr.Memo Header";
                    EInvoice: Codeunit 50200;
                begin
                    IF rec."Posting Date" <= 20200930D THEN
                        ERROR('You cannot create IRN Before than 1st Oct 2020');
                    rec.TESTFIELD("Acknowledgement No.");
                    rec.TESTFIELD("Acknowledgement Date");
                    rec.TESTFIELD("IRN Hash");
                    IF CONFIRM('Do you want to cancel the generated IRN?', FALSE) THEN BEGIN
                        CLEAR(EInvoice);
                        SalesCreditMemoHeader.RESET;
                        SalesCreditMemoHeader.SETFILTER("No.", '%1', rec."No.");
                        IF SalesCreditMemoHeader.FINDFIRST THEN BEGIN
                            EInvoice.SetCrMemoHeader(SalesCreditMemoHeader);
                            EInvoice.CancelSalesCreditIRNNo(SalesCreditMemoHeader);
                        END;
                    END;

                end;
            }

        }
    }

    var
        myInt: Integer;
}
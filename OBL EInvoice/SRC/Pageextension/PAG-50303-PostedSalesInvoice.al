pageextension 50303 pageextension50303 extends "Posted Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        modify("Generate IRN")
        {
            Visible = false;
        }
        addafter("&Invoice")
        {
            action(GenerateIRN1)
            {
                Caption = 'GenerateIRN';
                ApplicationArea = All;
                Promoted = true;

                trigger OnAction()
                var
                    EInvoice: Codeunit 50200;
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    IF rec."Posting Date" <= 20200930D THEN
                        ERROR('You cannot create IRN Before than 1st Oct 2020');
                    rec.TESTFIELD("Acknowledgement No.", '');
                    Rec.TESTFIELD("Acknowledgement Date", 0DT);
                    CLEAR(EInvoice);
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETFILTER("No.", '%1', rec."No.");
                    IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                        EInvoice.SetSalesInvHeader(SalesInvoiceHeader);
                        EInvoice.GenerateSalesInvJSONSchema(SalesInvoiceHeader);
                    END;
                end;
            }
            action(CancelIRN)
            {
                Caption = 'Cancel IRN';
                ApplicationArea = All;
                Promoted = true;
                trigger OnAction()
                var
                    EInvoice: Codeunit 50200;
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    IF Rec."Posting Date" <= 20200930D THEN
                        ERROR('You cannot create IRN Before than 1st Oct 2020');
                    Rec.TESTFIELD("Acknowledgement No.");
                    Rec.TESTFIELD("Acknowledgement Date");
                    Rec.TESTFIELD("IRN Hash");
                    IF CONFIRM('Do you want to cancel the generated IRN?', FALSE) THEN BEGIN
                        CLEAR(EInvoice);
                        SalesInvoiceHeader.RESET;
                        SalesInvoiceHeader.SETFILTER("No.", '%1', Rec."No.");
                        IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                            EInvoice.SetSalesInvHeader(SalesInvoiceHeader);
                            EInvoice.CancelSalesIRNNo(SalesInvoiceHeader);
                        END;
                    END;

                end;
            }

        }
    }

    var
        myInt: Integer;
}
pageextension 50302 pageextension50302 extends "Posted Transfer Shipments"
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
        addafter("&Navigate")
        {
            action(GenerateIRN1)
            {
                Caption = 'Generate IRN';
                ApplicationArea = All;
                Promoted = true;
                trigger OnAction()
                var
                    TransShptHeader: Record "Transfer Shipment Header";
                    EInvoice: Codeunit 50200;
                begin
                    IF rec."Posting Date" <= 20200930D THEN
                        ERROR('You cannot create IRN Before than 1st Oct 2020');
                    rec.TESTFIELD("Acknowledgement No.", '');
                    rec.TESTFIELD("Acknowledgement Date", '');
                    CLEAR(EInvoice);
                    TransShptHeader.RESET;
                    TransShptHeader.SETFILTER("No.", '%1', rec."No.");
                    IF TransShptHeader.FINDFIRST THEN BEGIN
                        EInvoice.SetTransferShipHeader(TransShptHeader);
                        EInvoice.GenerateTransferInvoiceJSONSchema(TransShptHeader);
                    END;
                end;
            }
            action("CancelIRN")
            {
                Caption = 'Cancel IRN';
                ApplicationArea = All;
                Promoted = true;
                trigger OnAction()
                var
                    TransShptHeader: Record "Transfer Shipment Header";
                    EInvoice: Codeunit 50200;
                begin
                    IF rec."Posting Date" <= 20200930D THEN
                        ERROR('You cannot create IRN Before than 1st Oct 2020');
                    rec.TESTFIELD("Acknowledgement No.");
                    rec.TESTFIELD("Acknowledgement Date");
                    rec.TESTFIELD("IRN Hash");
                    IF CONFIRM('Do you want to cancel the generated IRN?', FALSE) THEN BEGIN
                        CLEAR(EInvoice);
                        TransShptHeader.RESET;
                        TransShptHeader.SETFILTER("No.", '%1', rec."No.");
                        IF TransShptHeader.FINDFIRST THEN BEGIN
                            EInvoice.SetTransferShipHeader(TransShptHeader);
                            EInvoice.CancelTrfShipIRNNo(TransShptHeader);
                        END;
                    END;

                end;
            }
            action("Run Generate E Way Bill Transfer Invoice")
            {
                ApplicationArea = All;
                RunObject = page 50239;
                RunPageLink = "No." = FIELD("No.");
            }

        }
    }
}
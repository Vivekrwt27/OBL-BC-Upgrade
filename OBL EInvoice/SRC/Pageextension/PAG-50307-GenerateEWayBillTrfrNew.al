pageextension 50307 pageextension50307 extends "Generate EWay Bill Trfr New"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {

        addafter("Cancel E-way")
        {
            action("Generate E-Way BillNew1")
            {
                Caption = 'Generate E-Way Bill';
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    EInvoice: Codeunit 50200;
                    TransShptHeader: Record "Transfer Shipment Header";
                begin
                    IF Rec."Posting Date" <= 20200930D THEN
                        ERROR('You cannot create IRN Before than 1st Oct 2020');
                    Rec.TESTFIELD("E-Way Bill No.", '');
                    Rec.TESTFIELD("E-Way Generated", FALSE);
                    CLEAR(EInvoice);
                    TransShptHeader.RESET;
                    TransShptHeader.SETFILTER("No.", '%1', Rec."No.");
                    IF TransShptHeader.FINDFIRST THEN BEGIN
                        EInvoice.SetTransferShipHeader(TransShptHeader);
                        EInvoice.GenerateTransferInvoiceJSONSchemaEWB(TransShptHeader);
                    END;
                end;
            }
            action("TroubleShoot JSON1")
            {
                ApplicationArea = All;
                Caption = 'TroubleShoot JSON';
                Promoted = true;

                trigger OnAction()
                var
                    EInvoice: Codeunit 50200;
                    TransShptHeader: Record "Transfer Shipment Header";
                begin
                    IF Rec."Posting Date" <= 20200930D THEN
                        ERROR('You cannot create IRN Before than 1st Oct 2020');
                    Rec.TESTFIELD("E-Way Bill No.", '');
                    Rec.TESTFIELD("E-Way Generated", FALSE);
                    CLEAR(EInvoice);
                    TransShptHeader.RESET;
                    TransShptHeader.SETFILTER("No.", '%1', Rec."No.");
                    IF TransShptHeader.FINDFIRST THEN BEGIN
                        EInvoice.SetTransferShipHeader(TransShptHeader);
                        EInvoice.TroubleShootTransferInvoiceJSONSchemaEWB(TransShptHeader);
                    END;
                end;
            }
            action("Cancel E-Way1")
            {
                ApplicationArea = All;
                Caption = 'Cancel E-Way Bill';
                Promoted = true;

                trigger OnAction()
                var
                    gUserSetup: Record "User Setup";
                    EInvoice: Codeunit 50200;
                begin
                    gUserSetup.GET(USERID);
                    IF NOT gUserSetup."Cancel E-Way Bill" THEN
                        ERROR('You are not Authorized to Cancel E-Way Bill');
                    rec.TESTFIELD("E-Way Bill No.");
                    EInvoice.CancelEWayTransfer(Rec);
                end;
            }
            action("TroubleShoot Cancel E - Way")
            {
                ApplicationArea = All;
                Promoted = true;

                trigger OnAction()
                var
                    TransferShipmentHeader: Record "Transfer Shipment Header";
                    EInvoice: Codeunit 50200;
                begin
                    CLEAR(EInvoice);
                    TransferShipmentHeader.RESET;
                    TransferShipmentHeader.SETFILTER("No.", '%1', rec."No.");
                    IF TransferShipmentHeader.FINDFIRST THEN BEGIN
                        EInvoice.TroubleshootJSON(TransferShipmentHeader);
                    END;
                end;
            }
            action("Download E-Way Bill1")
            {
                ApplicationArea = All;
                Caption = 'Download E-Way Bill';
                Promoted = true;

                trigger OnAction()
                var
                    TransferShipmentHeader: Record "Transfer Shipment Header";
                    EInvoice: Codeunit 50200;
                begin
                    rec.TESTFIELD("E-Way Bill No.");
                    TransferShipmentHeader.SETRANGE("No.", rec."No.");
                    IF TransferShipmentHeader.FINDFIRST THEN
                        EInvoice.DownloadEWBTransferInv(TransferShipmentHeader);

                end;
            }

        }
    }

    var
        myInt: Integer;
}
pageextension 50306 pageextension50306 extends "Generate E Way Bill Invv New"
{
    layout
    {
        // Add changes to page layout here

    }

    actions
    {
        addafter("Generate E-Way Bill No Via IRN")
        {
            action("Generate E-Way Bill1")
            {
                Caption = 'Generate E-Way Bill';
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    EInvoice: Codeunit 50200;
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    IF Rec."Posting Date" <= 20200930D THEN
                        ERROR('You cannot create EWB Before than 1st Oct 2020');

                    Rec.TESTFIELD("E-Way Bill No.", '');
                    Rec.TESTFIELD("E-Way Generated", FALSE);
                    CLEAR(EInvoice);
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETFILTER("No.", '%1', Rec."No.");
                    IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                        EInvoice.SetSalesInvHeader(SalesInvoiceHeader);
                        EInvoice.GenerateSalesInvJSONSchemaEWB(SalesInvoiceHeader);
                    END;
                end;
            }
            action("TroubleShoot Generation1")
            {
                Caption = 'TroubleShoot Generation';
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    EInvoice: Codeunit 50200;
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    //TroubleShootJSON(Rec);
                    CLEAR(EInvoice);
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETFILTER("No.", '%1', Rec."No.");
                    IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                        EInvoice.SetSalesInvHeader(SalesInvoiceHeader);
                        EInvoice.TroubleshootSalesInvJSONSchemaEWB(SalesInvoiceHeader);
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
                    EInvoice.CancelEWaySalesInvoice(Rec);
                end;
            }
            action("TroubleShoot Cancel E - Way")
            {
                ApplicationArea = All;
                Promoted = true;

                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    EInvoice: Codeunit 50200;
                begin
                    CLEAR(EInvoice);
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETFILTER("No.", '%1', rec."No.");
                    IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                        EInvoice.TroublenshootCancelEWaySalesInvoice(SalesInvoiceHeader);
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
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    EInvoice: Codeunit 50200;
                begin
                    rec.TESTFIELD("E-Way Bill No.");
                    SalesInvoiceHeader.SETRANGE("No.", rec."No.");
                    IF SalesInvoiceHeader.FINDFIRST THEN
                        EInvoice.DownloadEWBSalesInv(Rec);

                end;
            }

        }

    }

    var
        myInt: Integer;
}
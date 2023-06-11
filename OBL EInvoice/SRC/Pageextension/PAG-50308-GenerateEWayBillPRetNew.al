pageextension 50309 pageextension50309 extends "Generate EWay Bill P. Ret New"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Cancel E-Way")
        {
            action("Generate E-Way-Bill No")
            {
                ApplicationArea = All;
                Promoted = true;

                trigger OnAction()
                var
                    gUserSetup: Record "User Setup";
                    EInvoice: Codeunit 50200;
                begin
                    rec.TESTFIELD("Truck No.");
                    gUserSetup.GET(USERID);
                    IF NOT gUserSetup."Generate E-Way Bill" THEN
                        ERROR('You are not Authorized to Generate E-Way Bill');
                    EInvoice.CreateJSONPurchReturn(Rec);
                end;
            }
            action(DownloadEwayBll)
            {
                ApplicationArea = All;
                Promoted = true;

                trigger OnAction()
                var
                    PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
                    EInvoice: Codeunit 50200;
                begin
                    rec.TESTFIELD("E-Way Bill No.1");
                    PurchCrMemoHdr.SETRANGE("No.", rec."No.");
                    IF PurchCrMemoHdr.FINDFIRST THEN
                        EInvoice.DownloadEWBPurchaseRet(Rec);

                end;
            }
            action(CancelEWay)
            {
                ApplicationArea = All;
                Promoted = true;

                trigger OnAction()
                var
                    gUserSetup: Record "User Setup";
                    EInvoice: Codeunit 50200;

                begin
                    gUserSetup.GET(USERID);
                    IF NOT gUserSetup."Cancel E-Way Bill" THEN
                        ERROR('You are not Authorized to Cancel E-Way Bill');

                    rec.TESTFIELD("E-Way Bill No.1");
                    EInvoice.CancelEWayReturn(Rec);
                end;
            }
            action(UpdateEwayBillNo)
            {
                ApplicationArea = All;
                Promoted = true;
                Visible = false;
                trigger OnAction()
                var
                    PurCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
                begin
                    PurCrMemoHeader.SetRange("No.", 'PDNDRA/2223/0261');
                    if PurCrMemoHeader.FindFirst() then begin
                        PurCrMemoHeader."E-Way Bill No.1" := '';//FORMAT(EWayBillNo);
                        PurCrMemoHeader."E-Way Bill Date1" := '';// EWayBillDateTime;
                        PurCrMemoHeader."E-Way Bill Validity" := '';//EWayExpiryDateTime;
                        PurCrMemoHeader."E-Way URL" := '';//
                        PurCrMemoHeader."E-Way Generated" := FALSE;//TRUE;
                        PurCrMemoHeader."E-Way Canceled" := TRUE;
                        PurCrMemoHeader."Reason of Cancel" := PurCrMemoHeader."Reason of Cancel"::" ";
                        PurCrMemoHeader.MODIFY;
                        PurCrMemoHeader.MODIFY;
                        MESSAGE('Modified');
                    end;
                end;
            }
        }
    }

    var
        myInt: Integer;
}
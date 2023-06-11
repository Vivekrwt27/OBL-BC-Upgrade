pageextension 50454 "Posted Purchase Invoice" extends "Posted Purchase Invoice"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Posting Description New"; Rec."Posting Description New")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }

    actions
    {

        addafter("&Invoice")
        {
            action("GST Self Invoice")
            {
                Promoted = true;
                ApplicationArea = all;
                trigger OnAction()
                var

                begin
                    PurchInvHeader.RESET;
                    PurchInvHeader.SETRANGE("No.", rec."No.");
                    IF PurchInvHeader.FIND('-') THEN
                        REPORT.RUNMODAL(50389, TRUE, FALSE, PurchInvHeader);
                END;

            }
            action("&Purchase Invoice")
            {
                Promoted = true;
                Image = Invoice;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(PurchInvHeader);
                    PurchInvHeader.PrintRecords(TRUE);
                end;

            }
            action("&Freight Voucher")
            {
                trigger OnAction()
                var
                    PILine: Record 123;
                    FreightVoucher: Report 50275;
                begin
                    PILine.RESET;
                    PILine.SETFILTER(PILine."Document No.", rec."No.");
                    IF PILine.FIND('-') THEN BEGIN
                        FreightVoucher.SETTABLEVIEW(PILine);
                        FreightVoucher.RUN;
                    END;

                end;
            }
            action("Purch Inv Copy")
            {
                ApplicationArea = All;
                Promoted = true;
                Caption = 'Purch Inv. Modify';

                trigger OnAction()
                var
                    RS: Record "Report Selections";

                begin
                    if RS.get(RS.Usage::"P.Invoice", 1) then begin
                        RS."Report ID" := 50707;
                        RS.Modify();
                    end;
                end;
            }

        }

    }

    var
        PurchInvHeader: Record 122;
}
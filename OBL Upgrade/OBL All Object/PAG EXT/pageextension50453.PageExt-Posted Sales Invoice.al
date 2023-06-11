pageextension 50453 "Posted Sales Invoice1" extends "Posted Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
        addafter("Posting Date")
        {
            field("Freight Amt"; Rec."Freight Amt")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Trade Discount"; Rec."Trade Discount")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Insurance Amount"; Rec."Insurance Amount")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Discount Charges %"; Rec."Discount Charges %")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Discount Amount"; Rec."Discount Amount")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }

    actions
    {
        addafter(Print)
        {
            action("Certificate Of Origen")
            {
                Caption = 'Certificate Of Origen';
                Promoted = true;
                Visible = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    IF UserSetup.GET(USERID) THEN BEGIN
                        IF UserSetup."Allow Order Conf" = FALSE THEN
                            ERROR('%1 has no permission to Print the Certificate of Origin', UserSetup."User ID");
                    END;
                    SalesInvHeader.RESET;
                    SalesInvHeader.SETRANGE("No.", Rec."No.");
                    IF SalesInvHeader.FINDFIRST THEN
                        REPORT.RUNMODAL(REPORT::"Certificate of Origin", TRUE, TRUE, SalesInvHeader);
                end;
            }

            action("GST Scrap Invoice")
            {
                Caption = 'GST Scrap Invoice';
                Image = CreateForm;
                Promoted = true;
                Visible = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";

                begin
                    /* IF (rec."Posting Date" >= 20200111D) AND ("GST Customer Type"::Registered = rec."GST Customer Type") AND (rec."IRN Hash" = '') THEN
                        ERROR('You cannot print the invoice without IRN ');

                    IF (rec."Posting Date" >= 20200111D) AND (rec."GST Bill-to State Code" = '19') AND (rec."IRN Hash" = '') THEN
                        ERROR('You cannot print the invoice without IRN '); RB16630 */

                    /* {
                    CLEAR(Scrapreport);
                                        SIHdr.RESET;
                                        SIHdr.SETRANGE(SIHdr."No.", Rec."No.");
                                        Scrapreport.SETTABLEVIEW(SIHdr);
                                        Scrapreport.RUN;
                    } */

                    SalesInvHeader.RESET;
                    SalesInvHeader.SETRANGE("No.", Rec."No.");
                    IF SalesInvHeader.FINDFIRST THEN BEGIN
                        PDF.InitalizePDF;
                        PDF.GeneratePDF_Invoice(SalesInvHeader."No.", 'C:\PDF', SalesInvHeader, 50278);
                        PDF.SetDefaultPrinter;
                    END;
                    REPORT.RUN(50278, TRUE, FALSE, SalesInvHeader);

                    PDF.SendMail(Rec);


                end;

            }
            action("GST Sales Invoice")
            {
                Caption = 'GST Sales Invoice';
                Enabled = true;
                Image = PrintVoucher;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = true;

                ApplicationArea = all;

                trigger OnAction()
                var
                    // TradingInvoiceReport: Report "Sales Invoice";
                    BoolStart: Boolean;
                    SalesCrMemoHeader: Record "Sales Cr.Memo Header";
                    Customer: Record Customer;
                begin

                    /* IF (rec."Posting Date" >= 20200111D) AND ("GST Customer Type"::Registered = rec."GST Customer Type") AND (rec."IRN Hash" = '') THEN
                        ERROR('You cannot print the invoice without IRN ');
                    if Customer.get(Rec."Bill-to Customer No.") then;

                    IF (rec."Posting Date" >= 20200111D) AND (Customer."State Code" = 'WB') AND (rec."IRN Hash" = '') THEN
                        ERROR('You cannot print the invoice without IRN '); RB16630 */


                    CLEAR(BoolStart);
                    SalesCrMemoHeader.RESET;
                    SalesCrMemoHeader.SETRANGE("Applies-to Doc. No.", rec."No.");
                    IF SalesCrMemoHeader.FINDFIRST THEN
                        BoolStart := TRUE
                    ELSE
                        PrintReport;
                    IF (BoolStart) THEN
                        IF USERID IN ['FA017'] THEN
                            PrintReport
                        ELSE
                            ERROR('You Cannot Print the Invoice Due to This Invoice is Already Cancelled.');
                end;
            }
            action("GST Sale Inv Nepal")
            {
                Caption = 'Sales Invoice Nepal';
                Enabled = true;
                Image = PrintVoucher;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = true;

                ApplicationArea = all;

                trigger OnAction()

                var
                    UserSetup: Record "User Setup";
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    IF UserSetup.GET(USERID) THEN BEGIN
                        IF UserSetup."Allow Order Conf" = FALSE THEN
                            ERROR('%1 has no permission to Print the Sale Invoice Nepal', UserSetup."User ID");
                    END;
                    SalesInvHeader.RESET;
                    SalesInvHeader.SETRANGE("No.", Rec."No.");
                    IF SalesInvHeader.FINDFIRST THEN
                        REPORT.RUNMODAL(REPORT::"GST Sales Invoice Nepal", TRUE, TRUE, SalesInvHeader);
                end;

            }
            action("Commercial Invoice Nepal")
            {
                Promoted = true;
                Visible = true;
                Enabled = true;
                Image = PrintVoucher;
                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                begin
                    IF UserSetup.GET(USERID) THEN BEGIN
                        IF UserSetup."Allow Order Conf" = FALSE THEN
                            ERROR('%1 has no permission to Print the Commercial Invoice Nepal', UserSetup."User ID");
                    END;
                    SalesInvHeader.RESET;
                    SalesInvHeader.SETRANGE("No.", rec."No.");
                    IF SalesInvHeader.FINDFIRST THEN
                        REPORT.RUNMODAL(REPORT::"Commercial Invoice Nepal", TRUE, TRUE, SalesInvHeader);

                end;
            }
            action("Commercial Invoice Nepal1")
            {
                Promoted = true;
                Visible = true;
                Enabled = true;
                Image = PrintVoucher;
                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                begin
                    IF UserSetup.GET(USERID) THEN BEGIN
                        IF UserSetup."Allow Order Conf" = FALSE THEN
                            ERROR('%1 has no permission to Print the Commercial Invoice Nepal', UserSetup."User ID");
                    END;
                    SalesInvHeader.RESET;
                    SalesInvHeader.SETRANGE("No.", rec."No.");
                    IF SalesInvHeader.FINDFIRST THEN
                        REPORT.RUNMODAL(REPORT::"Commercial Invoice Nepal1", TRUE, TRUE, SalesInvHeader);

                end;
            }
            action("Packing List / Weight List")
            {
                Promoted = true;
                Visible = true;
                Enabled = true;
                Image = PrintVoucher;
                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                begin
                    IF UserSetup.GET(USERID) THEN BEGIN
                        IF UserSetup."Allow Order Conf" = FALSE THEN
                            ERROR('%1 has no permission to Print the Packing List / Weight List', UserSetup."User ID");
                    END;
                    SalesInvHeader.RESET;
                    SalesInvHeader.SETRANGE("No.", rec."No.");
                    IF SalesInvHeader.FINDFIRST THEN
                        REPORT.RUNMODAL(REPORT::"Packing List / Weight List", TRUE, TRUE, SalesInvHeader);

                end;
            }
            action("Feedback form")
            {
                Promoted = true;
                Visible = true;
                Enabled = true;
                Image = PrintVoucher;
                trigger OnAction()
                begin
                    SalesInvHeader.RESET;
                    SalesInvHeader.SETRANGE("No.", rec."No.");
                    //      IF SalesInvHeader.FINDFIRST THEN
                    //      REPORT.RUN(50325,TRUE,FALSE,SalesInvHeader);
                    SalesInvHeader.FINDFIRST;
                    CLEAR(Feedbackform);
                    Feedbackform.SETTABLEVIEW(SalesInvHeader);
                    Feedbackform.RUNMODAL;

                end;

            }

        }
    }
    local procedure PrintReport()
    begin
        /*SalesInvHeader.RESET;
        SalesInvHeader.SETRANGE("No.","No.");
        SalesInvHeader.FINDFIRST;
        REPORT.RUN(50393,TRUE,FALSE,SalesInvHeader);
         */
        //MSVRN 091117 >>
        SalesInvHeader.RESET;
        SalesInvHeader.SETRANGE("No.", rec."No.");
        SalesInvHeader.FINDFIRST;
        //REPORT.RUN(50393,TRUE,FALSE,SalesInvHeader) //MSVRN 091117 /original blocked
        IF recCust.GET(Rec."Sell-to Customer No.") THEN;
        IF recCust."State Code" <> '19' THEN BEGIN
            recCustType.RESET;
            recCustType.SETRANGE(Code, recCust."Customer Type");
            IF recCustType.FINDFIRST THEN BEGIN
                IF recCustType."Hide Discount" = TRUE THEN
                    REPORT.RUN(50393, TRUE, FALSE, SalesInvHeader)
                ELSE
                    REPORT.RUN(50393, TRUE, FALSE, SalesInvHeader);
            END;
        END;

        IF (recCust."State Code" = '19') AND (SalesInvHeader."LC Number" = '') THEN
            //REPORT.RUN(50344,TRUE,FALSE,SalesInvHeader) for Nepal without discount.
            REPORT.RUN(50319, TRUE, FALSE, SalesInvHeader)
        ELSE
            ;
        IF (recCust."State Code" = '19') AND (SalesInvHeader."LC Number" <> '') THEN
            //REPORT.RUN(50344,TRUE,FALSE,SalesInvHeader) for Nepal without discount.
            //rEPORT.RUN(50198,TRUE,FALSE,SalesInvHeader);
            REPORT.RUN(50319, TRUE, FALSE, SalesInvHeader);



        //MSVRN 091117 <<

    end;

    var
        SalesInvHeader: Record 112;
        recCust: Record Customer;
        recCustType: Record "Customer Type";
        Feedbackform: Report 50325;
        PDF: Codeunit 50008;

}
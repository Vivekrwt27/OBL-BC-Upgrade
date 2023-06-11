report 50248 "Purch. Received not Invoiced"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\PurchReceivednotInvoiced.rdl';

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            DataItemTableView = SORTING("Posting Date", "No.", "Vendor Invoice No.")
                                ORDER(Ascending);
            RequestFilterFields = "Vendor Posting Group", "Location Code", "Posting Date", "Order No.";
            column(companyinfoName; companyinfo.Name)
            {
            }
            column(companyinfoName2; companyinfo."Name 2")
            {
            }
            column(Text004; Text004)
            {
            }
            column(Text005; Text005)
            {
            }
            column(CurrReportPageNo; STRSUBSTNO(Text004, FORMAT(CurrReport.PAGENO)))
            {
            }
            column(GETFILTERS; "Purch. Rcpt. Header".GETFILTERS)
            {
            }
            column(LocationCode; "Purch. Rcpt. Header"."Location Code")
            {
            }
            column(No; "Purch. Rcpt. Header"."No.")
            {
            }
            column(OderNo; "Purch. Rcpt. Header"."Order No.")
            {
            }
            column(PostingDate; "Purch. Rcpt. Header"."Posting Date")
            {
            }
            column(PayToVendorNo; "Purch. Rcpt. Header"."Pay-to Vendor No.")
            {
            }
            column(PayToName; "Purch. Rcpt. Header"."Pay-to Name")
            {
            }
            column(VendorInvoiceNo; "Purch. Rcpt. Header"."Vendor Invoice No.")
            {
            }
            column(VendorInvoiceDate; "Purch. Rcpt. Header"."Vendor Invoice Date")
            {
            }
            column(OrderQTY; OrderQTY)
            {
            }
            column(TQRNotInvoiced; "Purch. Rcpt. Header"."Total Qty. Rcd. Not Invoiced")
            {
            }
            column(expctcost; expctcost)
            {
            }
            column(CopyText; CopyText)
            {
            }
            column(STRSUBSTNO1; STRSUBSTNO(Text004, CopyText))
            {
            }
            column(TOTQTYNOTRECEIVED; "Purch. Rcpt. Header"."Total Qty. Rcd. Not Invoiced")
            {
            }
            column(TotalExCost; TotalExCost)
            {
            }

            trigger OnAfterGetRecord()
            begin

                //CALCFIELDS("Total Qty. Rcd. Not Invoiced");
                //CALCFIELDS("Total UnitCost(LCY)");
                expctcost := 0.0;
                /* IF "Total Qty. Rcd. Not Invoiced" = 0 THEN//16225 CurrReport.SHOWOUTPUT N/F
                     CurrReport.SHOWOUTPUT := FALSE;*/

                valueEntry.RESET;
                valueEntry.SETRANGE(valueEntry."Document No.", "No.");
                IF valueEntry.FIND('-') THEN
                    REPEAT
                        expctcost := expctcost + valueEntry."Cost Amount (Expected)";
                    UNTIL valueEntry.NEXT = 0;

                purchheader.RESET;
                purchheader.SETRANGE(purchheader."No.", "Purch. Rcpt. Header"."Order No.");
                IF purchheader.FIND('-') THEN
                    purchheader.CALCFIELDS(purchheader."Ordered Qty");
                OrderQTY := purchheader."Ordered Qty";


                CurrReport.PAGENO := 1;

                expctcost := 0.0;

                valueEntry.RESET;
                valueEntry.SETRANGE(valueEntry."Document No.", "No.");
                IF valueEntry.FIND('-') THEN
                    REPEAT
                        expctcost := expctcost + valueEntry."Cost Amount (Expected)";
                    UNTIL valueEntry.NEXT = 0;
                IF "Purch. Rcpt. Header"."Total Qty. Rcd. Not Invoiced" <> 0 THEN
                    TotalExCost += expctcost;

                purchheader.RESET;
                purchheader.SETRANGE(purchheader."No.", "Purch. Rcpt. Header"."Order No.");
                IF purchheader.FIND('-') THEN
                    purchheader.CALCFIELDS(purchheader."Ordered Qty");
                OrderQTY := purchheader."Ordered Qty";
            end;

            trigger OnPreDataItem()
            begin
                CopyText := '';
                companyinfo.GET;
                CurrReport.CREATETOTALS(expctcost);
                CLEAR(TotalExCost);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        //       RepAuditMgt.CreateAudit(50248)
    end;

    var
        expctcost: Decimal;
        CopyText: Text[30];
        companyinfo: Record "Company Information";
        PurchaseReceiptline: Record "Purch. Rcpt. Line";
        purchheader: Record "Purchase Header";
        OrderQTY: Decimal;
        valueEntry: Record "Value Entry";
        PrintToExcel: Boolean;
        ExcelBuffer: Record "Excel Buffer" temporary;
        Rowno: Integer;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        Text004: Label 'Purchase Received Not Invoiced %1';
        Text005: Label 'Page %1';
        TotalExCost: Decimal;
}


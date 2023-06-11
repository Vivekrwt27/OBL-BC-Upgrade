report 50145 "Pending Purchase Orders"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\PendingPurchaseOrders.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Purchase Line"; 39)
        {
            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                WHERE("Outstanding Quantity" = FILTER(<> 0),
                                      "Document Type" = CONST(Order));
            RequestFilterFields = "Document No.", "Item Category Code", "Gen. Prod. Posting Group", "Order Date";
            column(CompName2; CompName1)
            {
            }
            column(CompName3; CompName2)
            {
            }
            column(FilterString; 'Filters : ' + FilterString)
            {
            }
            column(DocumentType; "Purchase Line"."Document Type")
            {
            }
            column(DocumentNo_PurchaseLine; "Purchase Line"."Document No.")
            {
            }
            column(Status; "Purchase Line".Status)
            {
            }
            column(IndentNo; "Purchase Line"."Indent No.")
            {
            }
            column(VendorName; VendorName)
            {
            }
            column(No; "Purchase Line"."No.")
            {
            }
            column(Description2; Description + ' ' + "Description 2")
            {
            }
            column(PurchaseLine; "Purchase Line".Quantity)
            {
            }
            column(UnitofMeasure; "Unit of Measure")
            {
            }
            column(OutstandingQuantity; "Purchase Line"."Outstanding Quantity")
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(PHOrderDate; PH."Order Date")
            {
            }
            column(OutstandingAmount; "Outstanding Amount")
            {
            }
            column(LastFieldNo; LastFieldNo)
            {
            }
            column(PL_IndentDate; "Purchase Line"."Indent Date")
            {
            }
            column(PL_OrderDate; "Purchase Line"."Order Date")
            {
            }
            column(PL_LocationCode; "Purchase Line"."Location Code")
            {
            }
            column(PL_DocumentNo; "Purchase Line"."Document No.")
            {
            }
            column(PL_BuyFromVendorNo; "Purchase Line"."Buy-from Vendor No.")
            {
            }
            column(Vendor_PhoneNo; Vendor."Phone No.")
            {
            }
            column(PL_QtyRcdNotInvoiced; "Purchase Line"."Qty. Rcd. Not Invoiced")
            {
            }
            column(PL_ExciseAmount; 0)// 16630 blank "Purchase Line"."Excise Amount"
            {
            }
            column(PL_TaxPerc; 0)// 16630 blank "Purchase Line"."Tax %"
            {
            }
            column(PL_TaxAmount; 0)// 16630 blank "Purchase Line"."Tax Amount"
            {
            }
            column(PL_Type; "Purchase Line".Type)
            {
            }
            column(Excise; Excise)
            {
            }
            column(postatus; postatus)
            {
                OptionCaption = 'Not Approved,Approved';
                OptionMembers = "Not Approved",Approved;
            }
            dataitem("Purch. Rcpt. Line"; 121)
            {
                DataItemLink = "Order No." = FIELD("Document No.");
            }

            trigger OnAfterGetRecord()
            begin


                PurchHeader.RESET;
                PurchHeader.SETRANGE(PurchHeader."Document Type", "Purchase Line"."Document Type");
                PurchHeader.SETRANGE(PurchHeader."No.", "Purchase Line"."Document No.");
                IF PurchHeader.FINDFIRST THEN BEGIN
                    IF PurchHeader.Status = PurchHeader.Status::"Short Close" THEN
                        CurrReport.SKIP;
                    postatus := PurchHeader."Approval Status"
                END;

                // 16630 CurrReport.SHOWOUTPUT := FooterPrinted;
                FooterPrinted := FALSE;
                PH.GET("Purchase Line"."Document Type", "Purchase Line"."Document No.");

                CurrReport.SHOWOUTPUT(FALSE);

                IF ("Purchase Line"."Outstanding Quantity" = 0) THEN
                    CurrReport.SHOWOUTPUT(FALSE)
                ELSE
                    //   CurrReport.SHOWOUTPUT(TRUE);

                    /* 16630     CurrReport.SHOWOUTPUT :=
                       CurrReport.TOTALSCAUSEDBY = "Purchase Line".FIELDNO("Document No.");*/
                    /*
                     IF PrintToExcel THEN BEGIN
                     ExcelBuf.NewRow;
                     ExcelBuf.AddColumn("Purchase Line"."Document No.",FALSE,'',TRUE,FALSE,TRUE,'');
                    END;
                     */

                    /* CurrReport.SHOWOUTPUT :=
                       CurrReport.TOTALSCAUSEDBY = LastFieldNo;*/ // 16630


                    IF "Purchase Line"."Outstanding Quantity" = 0 THEN
                        CurrReport.SHOWOUTPUT(FALSE)
                    ELSE
                        CurrReport.SHOWOUTPUT(TRUE);

                Vendor.RESET;
                IF Vendor.GET("Purchase Line"."Buy-from Vendor No.") THEN
                    VendorName := Vendor.Name;

                PurchHeader.RESET;
                PurchHeader.SETRANGE(PurchHeader."Document Type", "Purchase Line"."Document Type");
                PurchHeader.SETRANGE(PurchHeader."No.", "Purchase Line"."Document No.");
                IF PurchHeader.FINDFIRST THEN BEGIN
                    IF PurchHeader.Status = PurchHeader.Status::"Short Close" THEN
                        NotShow := FALSE;
                    /* 16630  IF Type = Type::Item THEN BEGIN
                           ExcisePostingSetup.RESET;
                           ExcisePostingSetup.SETRANGE(ExcisePostingSetup."Excise Bus. Posting Group", "Excise Bus. Posting Group");
                           ExcisePostingSetup.SETRANGE("Excise Prod. Posting Group", "Excise Prod. Posting Group");
                           ExcisePostingSetup.SETRANGE("From Date", 0D, PurchHeader."Posting Date");
                           IF ExcisePostingSetup.FIND('+') THEN BEGIN
                               Excise := ExcisePostingSetup."BED %";
                           END;
                       END;*/ // 16630
                END;

                IF NOT FooterPrinted THEN
                    LastFieldNo := CurrReport.TOTALSCAUSEDBY;
                // 16630    CurrReport.SHOWOUTPUT := NOT FooterPrinted;
                FooterPrinted := TRUE;

                // IF "Purchase Line"."Outstanding Quantity" = 0 THEN
                // CurrReport.SKIP;
                //CurrReport.SHOWOUTPUT :=
                //CurrReport.TOTALSCAUSEDBY = "Purchase Line".FIELDNO("Document No.");

                /*  CurrReport.SHOWOUTPUT :=
                    CurrReport.TOTALSCAUSEDBY = "Purchase Line".FIELDNO("Document Type");*/ // 16630

            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                CompName1 := CompanyInfo.Name;
                CompName2 := CompanyInfo."Name 2";
            end;
        }
        dataitem(Vendor; 23)
        {
            RequestFilterFields = "No.";
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

        IF PrintToExcel THEN
            CreateExcelbook;
        //RepAuditMgt.CreateAudit(50145)
    end;

    trigger OnPreReport()
    begin

        IF PrintToExcel THEN
            MakeExcelInfo;
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        VendorName: Text[75];
        FilterString: Text[30];
        PH: Record "Purchase Header";
        CompanyInfo: Record "Company Information";
        CompName1: Text[100];
        CompName2: Text[100];
        ExcelBuf: Record "Excel Buffer" temporary;
        PrintToExcel: Boolean;
        // 16630  ExcisePostingSetup: Record 13711;
        Excise: Decimal;
        PurchHeader: Record "Purchase Header";
        NotShow: Boolean;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        Text1001: Label 'Payment Advice';
        Text1002: Label 'Data';
        Text1005: Label 'Company Name';
        Text1007: Label 'Report Name';
        Text1006: Label 'Report No.';
        Text1008: Label 'User ID';
        Text1009: Label 'Print Date';
        Text1011: Label 'Period Filter';
        TotalFor: Label 'Total for ';
        postatus: Option;

    procedure MakeExcelInfo()
    begin
    end;

    local procedure MakeExcelDataHeader()
    begin
    end;

    procedure CreateExcelbook()
    begin
        /*ExcelBuf.CreateBook;
        ExcelBuf.CreateSheet(Text1002,Text1001,COMPANYNAME,USERID);
        ExcelBuf.GiveUserControl;
        ERROR('');
         */

    end;
}

